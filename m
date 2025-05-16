Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C1E14A4F9
	for <linux-s390@vger.kernel.org>; Fri, 16 May 2025 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747404485; cv=none; b=L0dcTTTlvtJHE0/iBMo+M6C2jalwTJLvij4YI0q5NH++peAjjQSkVGNIzzTPMLGPKz6Yu1XqAV0w60f+rvwBEHqi1/Nx4WbzHaQXjZoKhfuV3/cnVKEXBImos0CDfbJYkEGF3EALQ1z4TOhTefTp1dV3oTlNRfabzHweqxu3xtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747404485; c=relaxed/simple;
	bh=RK9aBFyd79+Q/HcASRcOyCtzdOyDdFJ0ghx50/zDN/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nw9S+NbBXWgpmy2Kgmk5OxTfBLHN2iF41LMLoNQKbc+W7kHR85UO+YuvIS/wF64/8Fp7CJoOKuJzoN32QCxo+/2rBtwpNNZp+3+GcOkK38c6f8VzHiH5Y2MmvfXY/0JKN73LKnN/73zv1U1i1P+KUUKERFo4csTLfq+fxTipcVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIy91Ko6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIy91Ko6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747404482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Uq6KURHAsdiUcEMvv/uoqzWtUBzSDdD1xyqnhIAzcWM=;
	b=gIy91Ko6Zbi19nU8rgJ7ljd69lfRlzHvPlJF/eUHAoc0BnklSpLOafokRDt+lOOAWUbOvE
	MqhyaiFwTAVrNQDdxGSfoWbu1C+BeNjjZKQzXhTCstPTkMuGw2A4BoFLSeX1OZUbS36jZa
	U2namWy3pu3bg9wntkmxEdQryUqdc78=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-WSYYvIcrNxezQtxjp3Oaug-1; Fri, 16 May 2025 10:08:00 -0400
X-MC-Unique: WSYYvIcrNxezQtxjp3Oaug-1
X-Mimecast-MFC-AGG-ID: WSYYvIcrNxezQtxjp3Oaug_1747404480
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so11631965e9.3
        for <linux-s390@vger.kernel.org>; Fri, 16 May 2025 07:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747404479; x=1748009279;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uq6KURHAsdiUcEMvv/uoqzWtUBzSDdD1xyqnhIAzcWM=;
        b=NWtaU1xyUtJ957F84KJsRGnVMHuYEgNIFtHw/D+Q7RMLYqnyRvESkphur/swKNcHPe
         f5Y6Xcw5kPY6UYyWn2gECYcdjpOR2JKnVcVOwvcJMKN2VX0hvArHmlWie6OY3jw7WQmE
         eFXN5f4xe+xZAuq+sKGcf0Plfx92D9w9q41Bx6pZXDeUrY6Mg8HWKKL5OE5TrHn6Dx5j
         RCvPG5Y5qr8DOOSDqMO5ttWhAeA0zZKg/uFBKBSvznnd/duPiXcYRy/2TC7Etkzs6yhH
         RpNZzV+YlD4djqaEJVWtGRf2/YX1lNO3VBbYAQLofT/cwqPyrGNSRlnyP/p1hJmmt8z0
         VcVg==
X-Gm-Message-State: AOJu0YwRtEaiaCp9Y5/OKIdxRd2dhkuKm6NbhcFaOUBIFo9QhjjJuJyu
	LHT/jYDFf9/TP/SUN+4n0Ho/1RmuanIJCK+0mA/CPqz17e9A4UDG808zXxaU9Pdn43VqIHsQlFe
	bu+Pnzq2A3M0wL3BC0XQ26euSwO8WVHPEg+MTxSpowhjJSTiA36/qtnrXHr/P0KA=
X-Gm-Gg: ASbGnctGEma8bqZciE9wgUv5TnhbtXWijiwDfsJqB/gmuACrf5z/0ySfCLP7A/wNdd6
	w9BcDTPIfeZmQsZNyEAtYM7i5G787O7/f4g03pVD6wrtwt6pfVNtmJ0SHRwGa5itj/s+q1mHgDC
	Te8UBErZS1TP1Iz1Q0dmMVWHiUfcV5o5yT5hNyObq5HrY+trKYCpIgOyJGlLNmgSw6ABnf3WAI/
	RkAfba2GX/mpxz38KvJuI7CCZVnBJZRsnBMDlGFuPXru9dNkb5w2NVflwdQA589qY9c/f2FjXFU
	1tCuGxdcYqOKsJbFqVv2LbIQROOygxxDHqdGGB1zj1v1UUg8kwk9sc7ZV2FuexppkCfXlODu42d
	hNeN3SFNjRzm19bYZTJ9PE9Yn/cHNzeq18XrWWrs=
X-Received: by 2002:a05:600c:3f07:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-442fd60b516mr39862105e9.4.1747404479444;
        Fri, 16 May 2025 07:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErUF+kUAa2DUbbfcj03racps/O2R2c/jJuyRwdI2xUqjpHejuSvMBsI2MJ8NaMr9Z5ueg8yA==
X-Received: by 2002:a05:600c:3f07:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-442fd60b516mr39861295e9.4.1747404479012;
        Fri, 16 May 2025 07:07:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:4700:e6f9:f453:9ece:7602? (p200300d82f474700e6f9f4539ece7602.dip0.t-ipconnect.de. [2003:d8:2f47:4700:e6f9:f453:9ece:7602])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39e851bsm111513665e9.28.2025.05.16.07.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 07:07:57 -0700 (PDT)
Message-ID: <a8632cbd-704f-4ca8-b44b-fdc7e641b943@redhat.com>
Date: Fri, 16 May 2025 16:07:55 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] s390/uv: don't return 0 from make_hva_secure() if
 the operation was not successful
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
 Sebastian Mitterle <smitterl@redhat.com>, stable@vger.kernel.org
References: <20250516123946.1648026-1-david@redhat.com>
 <20250516123946.1648026-2-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250516123946.1648026-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.05.25 14:39, David Hildenbrand wrote:
> If s390_wiggle_split_folio() returns 0 because splitting a large folio
> succeeded, we will return 0 from make_hva_secure() even though a retry
> is required. Return -EAGAIN in that case.
> 
> Otherwise, we'll return 0 from gmap_make_secure(), and consequently from
> unpack_one(). In kvm_s390_pv_unpack(), we assume that unpacking
> succeeded and skip unpacking this page. Later on, we run into issues
> and fail booting the VM.
> 
> So far, this issue was only observed with follow-up patches where we
> split large pagecache XFS folios. Maybe it can also be triggered with
> shmem?

Yes! I can reproduce it when allocating pages outside of the qemu process.

$ echo force > /sys/kernel/mm/transparent_hugepage/shmem_enabled
$ rm /dev/shm/vm-ram
$ fallocate -l 4G /dev/shm/vm-ram
$ /usr/libexec/qemu-kvm ... -object 
memory-backend-file,id=mem0,size=4g,share=on,mem-path=/dev/shm/vm-ram -M 
memory-backend=mem0

LOADPARM=[        ]

Using virtio-blk.
Using SCSI scheme.
.........................................................................................................................
qemu-kvm: KVM PV command 4 (KVM_PV_VERIFY) failed: header rc 102 rrc 1a 
IOCTL rc: -22
Protected boot has failed: 0xa02
Guest crashed on cpu 0: disabled-wait
PSW: 0x0002000080000000 0x0000000000004608


-- 
Cheers,

David / dhildenb

