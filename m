From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [GIT PULL 1/1] KVM: s390: Fix hang VCPU hang/loop regression
Date: Thu, 30 Jul 2015 13:43:58 +0200
Message-ID: <55BA0DFE.9080905@de.ibm.com>
References: <1438255366-25805-1-git-send-email-borntraeger@de.ibm.com> <1438255366-25805-2-git-send-email-borntraeger@de.ibm.com> <55BA0CB5.1090605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <55BA0CB5.1090605@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Am 30.07.2015 um 13:38 schrieb Paolo Bonzini:
> 
> 
> On 30/07/2015 13:22, Christian Borntraeger wrote:
>>  static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
>>  {
>> -	if (!vcpu->requests)
>> -		return 0;
>>  retry:
>>  	kvm_s390_vcpu_request_handled(vcpu);
>> +	if (!vcpu->requests)
>> +		return 0;
>>  	/*
> 
> Should kvm_s390_vcpu_request_handled(vcpu); go before the retry label?
> 
> It shouldn't be too common to have two requests, and you're doing an 
> extra atomic operation to clear PROG_REQUEST.

Handling a request is slow path anyway and my last optimization was not
considering all side effects - so give me some time to comsume your comment 
to make it better this time....

[...]
> This of course should be for 4.3

yes :-)


> ---I've pulled your branch into kvm/master.
