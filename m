Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB3F2E7165
	for <linux-s390@vger.kernel.org>; Tue,  2 Sep 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800393; cv=none; b=hi7qVZj5jhQcqJuUlW9yIOT7pziiTz6Db7txOM9adztI31wugWAroEHtNw2NQ5coP2rRcdIAT700Ohb+IaC+upwJjl8ogB9NN59gpiHKTZFDd96c9eEc+gkXvACbE8W3boux2pyvLH0z8Uxeyc+SGVRmLI6JbHwpy8YLEnAueTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800393; c=relaxed/simple;
	bh=4scRMf+tgOHgOIs5Lo1D7TauGpjXrxuh4vo6a6YZUyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=agXyeHPIQRdyjKmFf3VN+i+9tCMh3Ei4UR9iO/oqAgvNuWnpT9VusDw2UZJiX4iCikfUpkl7RPTP1n/ybmOsU+cgcUwqsDouPHAkRUumlGyCe7qQbeoZIcL9RaoEy1oeazjgyZ00BiuWfIk+nnpsmKLOiIO2AvRMAKpkvSolodU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6F1+WtY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6F1+WtY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756800391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IpJ7H8N7FFsIL+sZVKXca+TmDGWYx1b6cFxz+BZpneM=;
	b=a6F1+WtYkFr72LliXr+eYiW3ttqeBls6QMSEj2lWk0YcEHGUEmBvwpZ5FceOIf/dJdg9fY
	SV09sH72fD6a+zJFrLa8vxKmlrpRCEHZjlMNp1m5b++2c0roQgwcapmbeNM+Ae5LjGVXfb
	XJ6pRjdwf6XmXFG92YVU25GljuAmIAY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-ELHgYN6yMfC3Fm_ddsEAOw-1; Tue, 02 Sep 2025 04:06:29 -0400
X-MC-Unique: ELHgYN6yMfC3Fm_ddsEAOw-1
X-Mimecast-MFC-AGG-ID: ELHgYN6yMfC3Fm_ddsEAOw_1756800389
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3d79c7fa313so906560f8f.3
        for <linux-s390@vger.kernel.org>; Tue, 02 Sep 2025 01:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800388; x=1757405188;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpJ7H8N7FFsIL+sZVKXca+TmDGWYx1b6cFxz+BZpneM=;
        b=EeqqEXvPLl85XLPa2XZ8ss3lsxH8MQI7ZD/aaJWpSd1EYaDSbwnRfmOsMvidd6+AUr
         o9DwRoChOpdDFLm80rdPSN4/fYD6MydpIAuCjz2wRCroL1PzzPt3ZZ6mIGPUuNja81Ff
         yqyRagVrUGMg+1VCvWQWi+IDgVprJAwG/KchE4UOfFT5qS6e/icwuSBETKMCoBkMOr1u
         sr30BI4HsdJKS5ao7vabiCI5imQFOINx7ebqS2MpB1maiHtSKQtGfOcJ4Cwb53BXDbnT
         fhtdxAanPtzSIKvHUxo9ydyUajXCnxIR6RXkdznI61WcfxH6DVFnj8MAyon5VYXJhOFU
         fD0w==
X-Forwarded-Encrypted: i=1; AJvYcCUl+YQE7tej0rPW2PJdcXC6BaawWuEo52EYXu0l+bMml00CZBU3r9fmZxr41s7ni1/yUPvWljG6LO52@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc6TT+Hm9EU3CE2UtmODKdMWVvOTjkmfW9WDo1/78ilB/7dqbU
	InCmkxgXG+1lUmnhUGAhMpQ3gxBYw/RWrM0YCkrhzNULoM9tNFSq6xahkoTdTaqNQlAuV22jr8U
	QMZMRAMJ3o2TssQz4FtyJ97mCICRR5GXGd2XHDpLcJwP0tXiZBqFXqNSbYE2y5YI=
X-Gm-Gg: ASbGncvK014Ur31YfHNSqB20tkW7bIzA2MEKsy7Wn+V6BOCobd2zgLJEVI6o3aqGyiA
	SfT45UIemSttQ3UaceknhPAPaJ/O+Ftl/qdpnldQQIas2oNyTv6u+E+C7shJ8rb2BZqVGwxEtxZ
	OS2EUEXo/kEQgWfTyMf8JCLrPPTyIqKnOwMHohRhTsSMdLUKji4MH/3BoCoPu+Vdl44yYLs/LYA
	n3pbxop7jY0uWESSClyDtYtnMTd3hQ8n5UX5chrBUWydemvGSWIRDAGDPjHf2V7qEd7PgppKJTA
	xNn7x8z0ObI4D4XoIV4r05dxdlEhy091WWgTSHCyGn+hR9ZFUt5JuV4JX4yHFbosHBPBYtgHlvK
	dt4P2Io7em3F8QLA9th6728hXxaEDGa5M1JlgZax/LrVTy2wcVCAJGVEh7dKGbPnF4UY=
X-Received: by 2002:adf:b303:0:b0:3d2:82d:7da0 with SMTP id ffacd0b85a97d-3d2082d8289mr5428472f8f.43.1756800388516;
        Tue, 02 Sep 2025 01:06:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTerYgExLKpnch27eawnPrT4O2stkgHXpcDmb8FTUCEqRSxftMR8giHgH9SA0676g8Q5jadw==
X-Received: by 2002:adf:b303:0:b0:3d2:82d:7da0 with SMTP id ffacd0b85a97d-3d2082d8289mr5428419f8f.43.1756800388024;
        Tue, 02 Sep 2025 01:06:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d690f2edf1sm7891634f8f.16.2025.09.02.01.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:06:27 -0700 (PDT)
Message-ID: <ea4adc86-abf9-4ab8-999a-eb4c7bad4cd3@redhat.com>
Date: Tue, 2 Sep 2025 10:06:24 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/12] mm: constify assert/test functions in mm.h
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@HansenPartnership.com, deller@gmx.de,
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 davem@davemloft.net, andreas@gaisler.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net,
 jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, weixugc@google.com, baolin.wang@linux.alibaba.com,
 rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com,
 broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com,
 mpe@ellerman.id.au, nysal@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
 <20250901205021.3573313-12-max.kellermann@ionos.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901205021.3573313-12-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 22:50, Max Kellermann wrote:
> For improved const-correctness.
> 
> We select certain assert and test functions which either invoke each
> other, functions that are already const-ified, or no further
> functions.
> 
> It is therefore relatively trivial to const-ify them, which
> provides a basis for further const-ification further up the call
> stack.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

