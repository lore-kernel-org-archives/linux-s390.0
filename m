Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752708;
	b=JsMfrPrpS/L+/jW7C9C2bnl/1/wkwE0BHhV7eSXQiWNU1vb/1az0GjthgfZIdGI7xgdk
	 cNKV0SD5fphi+0/UOBagKqgl30dJLkf6hKsDccG7e1okgrJwhufFO7hF6m/2cL5fsMBVP
	 MKOrDQwTfbK0L1l1NlW/AsyCGKhvAs6OiTY4Kq/xNAGIqp2ZzWWTtfOe3Y/tqofKSXUdy
	 WAlGk97yzKUxoq5Yxht4H9wG18+CC/7M+TAWyMRUv0ejKsCj84JLm3aLkr0jLkU6qDbnJ
	 8XcIfbOwUiXtDEV2/hwwOGBuex4+zg1Uov/Z4AYu5smCwhs/DkhOqZGEYk54DiFbqQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752708;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=/JbHR9SIBAy4VraxiGZbUfiitTfcvjB9kaCB6rQcVIE=;
	b=YHaOfxnZ28FgEYdncWmcx1l5OiMLtVxs333ifdFpIGk48Qgk4MZOj9Iedo5FPAMHnepg
	 BcwqxKQlINoQ9dxCvELS3KBZFWQng2w85y/h/ikmoMi+XBBPvZAct+WZI2xUfdgCJyGNM
	 ZRIbo61a6nZ3SyaANmvx/7mm5grLqian8I/eSnCvpCTzdusxXOt5HXQteDfLB/yrtjzt9
	 XF0oaZMeCDDGCN36+zqt5W0y7UPokCtWG6X651b2arsgfoSw/+CUHAUmfMC/wuBSuMKr4
	 fERDPD/gPByYFPQGlvQ+2hgKJJXfvsyFT77yLFseCEIaoXYRDhaSuXptj9w6GABho6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hMeETv55;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RAzpJdiv;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hMeETv55;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RAzpJdiv;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406E5606A31B;
	Wed,  4 Nov 2026 00:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 406E5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hMeETv55;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RAzpJdiv;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hMeETv55;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RAzpJdiv
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48D231FBFA;
	Wed,  4 Nov 2026 00:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793752706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JbHR9SIBAy4VraxiGZbUfiitTfcvjB9kaCB6rQcVIE=;
	b=hMeETv5530ymyrmx6uaNyir9LG6FBv0uQEl0WwmKicpUSBvRCnBi/EFlzkwrOdHSffoszn
	IZeJVADnNtfHp7lImgCYnmoFu3/kY74RyqE2giHL+KMLqzZp89a8feFt9brP76376iYif5
	eEHqenwPS4xADyWP82Xcpyjnps0ZiOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793752706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JbHR9SIBAy4VraxiGZbUfiitTfcvjB9kaCB6rQcVIE=;
	b=RAzpJdivgGshNrHzYe/w5E5DSJibua0ozUzsjj6q8zz3RRQDhKh2fMv5EBNSmaCY83ixH4
	3wCgewfKfRUSHvCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793752706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JbHR9SIBAy4VraxiGZbUfiitTfcvjB9kaCB6rQcVIE=;
	b=hMeETv5530ymyrmx6uaNyir9LG6FBv0uQEl0WwmKicpUSBvRCnBi/EFlzkwrOdHSffoszn
	IZeJVADnNtfHp7lImgCYnmoFu3/kY74RyqE2giHL+KMLqzZp89a8feFt9brP76376iYif5
	eEHqenwPS4xADyWP82Xcpyjnps0ZiOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793752706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JbHR9SIBAy4VraxiGZbUfiitTfcvjB9kaCB6rQcVIE=;
	b=RAzpJdivgGshNrHzYe/w5E5DSJibua0ozUzsjj6q8zz3RRQDhKh2fMv5EBNSmaCY83ixH4
	3wCgewfKfRUSHvCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C07B9134A0;
	Wed,  4 Nov 2026 00:38:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4fW7I4F+6mqncAAAD6G6ig
	(envelope-from <clopez@suse.de>); Wed, 04 Nov 2026 00:38:25 +0000
Message-ID: <7ba2ca65-1eab-40fd-ae4c-f7cd9e156d8c@suse.de>
Date: Wed, 4 Nov 2026 01:38:21 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] KVM: x86/mmu: don't zap secondary MMU on
 permission upgrade
To: Sean Christopherson <seanjc@google.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
 linux-mm@kvack.org, pbonzini@redhat.com, linux-s390@vger.kernel.org
References: <20261029143336.390231-3-clopez@suse.de>
 <20261029175203.5bdd51d7@p-imbrenda>
 <df9dc526-4275-4784-8a0c-2e4fa8e96402@suse.de>
 <20261030133939.630e29af@p-imbrenda> <auis0SaMkRB6odsK@google.com>
 <b9ed9dd4-a1d0-466b-a6cd-89a4e70abed0@suse.de> <aun3w8gxwlmRy-GW@google.com>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <aun3w8gxwlmRy-GW@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

On 11/3/26 4:03 PM, Sean Christopherson wrote:
> On Tue, Nov 03, 2026, Carlos López wrote:
>> On 11/2/26 4:31 PM, Sean Christopherson wrote:
>>> On Fri, Oct 30, 2026, Claudio Imbrenda wrote:
>>>> On Fri, 30 Oct 2026 12:11:07 +0100
>>>> Carlos López <clopez@suse.de> wrote:
>>>>
>>>> [...]
>>>>
>>>>>> regarding this series:
>>>>>>
>>>>>> on x86 you don't care what the new permissions are, because you're
>>>>>> updating when re-faulting (if I understood correctly).  
>>>>>
>>>>> Correct.
>>>>>
>>>>>> for s390 it might be beneficial to know what the new permissions are;
>>>>>> of course we could look up the vma and find out, but since you are
>>>>>> already checking the permissions, maybe you can find a way to also
>>>>>> convey the new permission bits?
>>>>>>
>>>>>> that would make our life on s390 easier :)  
>>>>>
>>>>> Right, getting the new bits from vma->flags should be trivially done
>>>>> from the MMU_NOTIFY_PROTECTION_VMA callsites. There'd be no users in
>>>>> this series though.  The rest of architectures still need the notifier to
>>>>> tell them if the change is an upgrade, since they don't have an easy way
>>>>> to grab the old RWX bits. Passing the old RWX bits from the MMU notifier
>>>>> does not seem trivial to me either.
>>>
>>> But why is core MM even doing mmu_notifier_invalidate_range_{start,end}() in the
>>> first place?  I.e. why add MMU_NOTIFIER_RANGE_PERM_UPGRADE?  Just skip the
>>> "invalidation".
>>
>> I briefly mention this in the cover letter, but in short, denying other
>> users the notification seems like an overly intrusive change for KVM's
>> benefit. 
> 
> There are all of two other users:
> 
>   $ git grep -w "\.invalidate_range_start"
>   drivers/gpu/drm/nouveau/nouveau_svm.c:  .invalidate_range_start = nouveau_svmm_invalidate_range_start,
>   drivers/infiniband/hw/hfi1/mmu_rb.c:    .invalidate_range_start = mmu_notifier_range_start,
>   virt/kvm/kvm_main.c:    .invalidate_range_start = kvm_mmu_notifier_invalidate_range_start,
> 
> and AFAICT neither of them wants an invalidation even for protection upgrades
> either.

There are more users that register for notifications via
mmu_interval_notifier_insert():

  $ git grep -l -e "mmu_interval_notifier_insert(" \
          -e "mmu_interval_notifier_insert_locked(" -- drivers/ | wc -l
  12

I haven't audited all of them, but I'd say that at least amdkfd relies
on the invalidation for upgrades. Without XNACK, GPU page faults are not
retried, so the driver maps ranges up front with the VMA permissions
(svm_range_validate_and_map()) and relies on an invalidation to remap
them when those change. So mprotect(PROT_READ) followed by
mprotect(PROT_READ|PROT_WRITE) would cause the GPU mapping to stay
read-only and the next GPU write to fault. Unlike the APIC access page,
this is the application's own memory, mprotect() should be perfectly valid.

This is the kind of subtle reliance that I mentioned before, and why I'd
rather not open that can of worms.

>> A flag allows users to opt in instead.
>>
>> It is also not clear to me that secondary MMUs are not relying on the
>> notification in some subtle way. In fact, Sashiko points out in reply to
>> patch 4 that the notification lets KVM retry the APIC access page reload
>> in case userspace shoots itself in the foot by calling
>> mprotect(PROT_READ) on it. This would require a really weird VMM,
> 
> s/weird/misbehaving
> 
>> as it would need to go looking for the page's address, but breaking this
>> would be a "regression" nonetheless. I will address this in v2.
> 
> Nah, there's zero chance any real VMM is doing mprotect() on the APIC access page.
> 
> More importantly, doing nothing if updating the mapping fails and APICv is enabled
> is wrong.  KVM needs to ensure vmcs.APIC_ACCESS_ADDR is fresh when running a vCPU
> with APICv enabled, even if that means putting the vCPU into an infinite loop.
> VMX doesn't support "inhibiting" the APIC access page, i.e. the memslot can't
> disappear while the VM is alive, and if userspace mucks with the VMA, then KVM
> needs to prevent running the vCPU until the mapping is restored, irrespective of
> mmu_notifiers.

Fair point. Should I just carry the diff below in v2 with your
Signed-off-by?

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 464d6ed862d5..11b24a42e482 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6928,8 +6928,10 @@ void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
>  	 * APICv is enabled, but paranoia won't hurt in this case.
>  	 */
>  	slot = id_to_memslot(slots, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT);
> -	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
> +	if (WARN_ON_ONCE(!slot || slot->flags & KVM_MEMSLOT_INVALID)) {
> +		kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
>  		return;
> +	}
>  
>  	/*
>  	 * Ensure that the mmu_notifier sequence count is read before KVM
> @@ -6946,8 +6948,10 @@ void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
>  	 * if APICv is permanently inhibited, i.e. the memslot won't reappear.
>  	 */
>  	pfn = __kvm_faultin_pfn(slot, gfn, FOLL_WRITE, &writable, &refcounted_page);
> -	if (is_error_noslot_pfn(pfn))
> +	if (is_error_noslot_pfn(pfn)) {
> +		kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
>  		return;
> +	}
>  
>  	read_lock(&vcpu->kvm->mmu_lock);
>  	if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn))

