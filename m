Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955824D489C
	for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2026 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561986; cv=none; b=FZ4D8vowz2AuydggKHoLpfzM5b6zROiVcKeFAV7PucGq/5KsEdf2Jl57kqLcfzDzT7jvFPpZrMyhsozxtKjNiE9A/qyPl8YcmowChEBNLQQgAvoP7IUmnSCJXvBo1UiwLbPUh+H0abtL0J5w5klScZn8ieEsJck2pa05vr5rz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561986; c=relaxed/simple;
	bh=WHf77Yd5DASFhOAaaOdf6g+ghry/Kw8R/boOFhyWaRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/Vsmc5xxr8zq2sEu7kP7+eQRm6bnrG4Ujp0Vp32SiAYXHpEBvK3bQ9nUULUmlujj+z49kcazTILW0J6DXCpAJTecrCB5vDyasy15Syf55AwQQhQHDHIGrNqo7EakGGn4mZTtazri2D33fCkHFBNKnlZOysXzD0A+4cWoXKz+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjR9n1an; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjR9n1an"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791561983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UWLmuV+VOitmDREu5SKD8TR8ZykYME/n6JVVWgUeAEU=;
	b=AjR9n1anNgynw3TuWzyJsBU+b/JD1hIU6US1+MVA9iqnFMAlhRHGcXlD+tYRJbLnqJmYjU
	KcDHAt4ibOMuBT8xKEwbIZmyL1zmlnnX38FQ0OI0vRQVF8tYmC7PCfQJlKUeHvmk6AIh3h
	JtKf+Eu6W1ij5ONNCCIZ3o60gZrksFY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-fPBwmwcGP_-ruLyfe5J9dQ-1; Fri,
 9 Oct 2026 16:06:21 +0000
X-MC-Unique: fPBwmwcGP_-ruLyfe5J9dQ-1
X-Mimecast-MFC-AGG-ID: fPBwmwcGP_-ruLyfe5J9dQ_1791561978
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89F4F18021EA;
	Fri,  9 Oct 2026 16:06:18 +0000 (UTC)
Received: from [100.90.56.12] (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9DB3A1956042;
	Fri,  9 Oct 2026 16:06:16 +0000 (UTC)
Message-ID: <4944d4a4-cb8d-4c46-aa84-c0050991cffb@redhat.com>
Date: Fri, 9 Oct 2026 18:06:14 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 4/6] KVM/vfio: Use file-based reference counting for
 KVM
To: sashiko-reviews@lists.linux.dev,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: kvm@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20261009142749.186650-1-borntraeger@linux.ibm.com>
 <20261009142749.186650-5-borntraeger@linux.ibm.com>
 <sashiko-outbox-165746@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <sashiko-outbox-165746@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/9/26 16:56, sashiko-bot@kernel.org wrote:
>> -static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
>> +static void vfio_device_file_set_kvm(struct file *file, struct file *kvm)
>>   {
>>   	struct vfio_device_file *df = file->private_data;
>> +	struct file *old;
>> +
>> +	if (kvm)
>> +		get_file(kvm);
> 
> [Severity: Critical]
> Does taking a strong reference to the KVM file here create a circular
> reference cycle?
> 
> When userspace adds a VFIO device to a KVM VM, kvm_vfio_file_add() takes a
> reference to the VFIO file. If vfio_device_file_set_kvm() then takes a
> reference to the KVM file, both files hold references to each other.
> 
> Because both file descriptors hold each other's references, their f_count
> will never reach 0 when userspace closes the FDs, permanently leaking the
> KVM VM and the VFIO structures.

False positive, the reference to VFIO is in the KVM-VFIO device file and 
not in the KVM file descriptor itself.  Using variable names, there is 
one reference from kvf to vfio and one from vfio to kvm.

(Right? :))

Paolo



> [ ... ]
> 
>> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
>> index 6cdc4e9a333a3..19548a4309426 100644
>> --- a/virt/kvm/vfio.c
>> +++ b/virt/kvm/vfio.c
>> @@ -144,6 +144,7 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
>>   {
>>   	struct kvm_vfio *kv = dev->private;
>>   	struct kvm_vfio_file *kvf;
>> +	struct file *kvm_file __free(fput) = NULL;
>>   	struct file *filp __free(fput) = NULL;
>>   
>>   	filp = fget(fd);
>> @@ -154,6 +155,10 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
>>   	if (!kvm_vfio_file_is_valid(filp))
>>   		return -EINVAL;
>>   
>> +	kvm_file = get_file_active(&dev->kvm->file);
> 
> [Severity: High]
> Does struct kvm contain a member named 'file'? Looking at
> include/linux/kvm_host.h, it doesn't appear to exist, which would cause a
> compilation error here.
> 
>> +	if (!kvm_file)
>> +		return -ENOENT;
>> +
>>   	guard(mutex)(&kv->lock);
>>   
>>   	list_for_each_entry(kvf, &kv->file_list, node) {
>> @@ -168,7 +173,7 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
>>   	kvf->file = get_file(filp);
>>   	list_add_tail(&kvf->node, &kv->file_list);
>>   
>> -	kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
>> +	kvm_vfio_file_set_kvm(kvf->file, kvm_file);
> 
> [Severity: Critical]
> This is where KVM takes its strong file reference on the VFIO device file,
> which completes the reference cycle discussed above.
> 

