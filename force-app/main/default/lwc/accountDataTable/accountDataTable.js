import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountDataController.getAccounts';
import getTotalAccountCount from '@salesforce/apex/AccountDataController.getTotalAccountCount';

export default class AccountDataTable extends LightningElement {
    @track accounts = [];
    @track isLoading = false;
    @track hasError = false;
    @track errorMessage = '';
    @track currentPage = 1;
    @track pageSize = 5;
    @track totalRecords = 0;
    @track totalPages = 0;

    columns = [
        { label: 'Account Name', fieldName: 'Name', type: 'text' },
        { label: 'Website', fieldName: 'Website', type: 'url', typeAttributes: { target: '_blank' } },
        { label: 'Fax', fieldName: 'Fax', type: 'text' }
    ];

    connectedCallback() {
        this.loadTotalCount();
        this.loadPage();
    }

    async loadTotalCount() {
        try {
            const count = await getTotalAccountCount();
            this.totalRecords = count;
            this.totalPages = Math.ceil(this.totalRecords / this.pageSize);
        } catch (error) {
            this.handleError(error);
        }
    }

    async loadPage() {
        this.isLoading = true;
        this.hasError = false;
        try {
            const result = await getAccounts({ pageSize: this.pageSize, pageNumber: this.currentPage });
            this.accounts = result;
        } catch (error) {
            this.handleError(error);
        } finally {
            this.isLoading = false;
        }
    }

    handlePrev() {
        if (this.currentPage > 1) {
            this.currentPage--;
            this.loadPage();
        }
    }

    handleNext() {
        if (this.currentPage < this.totalPages) {
            this.currentPage++;
            this.loadPage();
        }
    }

    get isFirstPage() {
        return this.currentPage <= 1;
    }

    get isLastPage() {
        return this.currentPage >= this.totalPages;
    }

    get hasNoData() {
        return !this.isLoading && !this.hasError && (!this.accounts || this.accounts.length === 0);
    }

    handleError(error) {
        this.hasError = true;
        this.errorMessage = error.body ? error.body.message : error.message;
    }
}