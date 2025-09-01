Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D550311963
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724806; cv=none; b=HEA509RDLUhRNnufaT9BUPyogUGJ3jd5/KBTrTip4rk3iJxZuv0+JkCImhAiU52zWUK9ztGh25SX91FaeaAH65bY4J+PYnVgVsrsEmGqYxqH5GVl7dpdhXqW6Ctt8IaAuxhPL/+a4Yr/x/I+4DdiqPftcptwqLbQKdzlfjxkiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724806; c=relaxed/simple;
	bh=ga8tPWbGoRl43Jui+wBSo3njIyDe/0n706oJxLzlx1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfH8xfHcwUnBARfsRgAic8kCqvfcdGJ8dE19zWFlLuth0QFHKIitgtwaAZp+ze8LizzDPO7rALN9PxQiU31gjHMGBf6yArT0l3MeAbnuvDVb4SDXYa/Oi/QPktlafZOcnLSneqHSVrX9s6YUvksUjg1uf8x/K6msyCgODkiIdXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4bXy+sP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4bXy+sP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756724804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QVr1dt3a4WUVmixiCg4dgFeOh7bWE/lfiJ8EO3O1Gpo=;
	b=a4bXy+sPOHBvg1BVekOF3bXhJ/XybPM1Kob21YdJjeffNLPMceDqVYsNUzTZ1m8U7KN5AX
	zEuJjQxmcwN67YKNK6wI3QZ0pH1+HsqBoydG/3YLONXrNCMJOKg4l1b8rLjrZd/in+262u
	j2Zve6GE76DYKevTWDjSUflWSDOOstw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-d22HruOWPWazmEHnIKzqXQ-1; Mon, 01 Sep 2025 07:06:43 -0400
X-MC-Unique: d22HruOWPWazmEHnIKzqXQ-1
X-Mimecast-MFC-AGG-ID: d22HruOWPWazmEHnIKzqXQ_1756724802
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3cbe70a7861so3072236f8f.3
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 04:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756724802; x=1757329602;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVr1dt3a4WUVmixiCg4dgFeOh7bWE/lfiJ8EO3O1Gpo=;
        b=YuC2GFjMuVKJcYqVudqvuzbOeXrRYOhzsOlyBg85sXz2J9aNSPmEfbekXq9bujbVTJ
         /nVcKlDSzg0CBSOmCSPcVQ/iU7IWn8m7yY5Aus/OxQApvafA2YJohuGZ1T/GK4IaGJ4x
         vLXDXpIMBLM/9QLRz9Ks94TxREYyE/pNlOuoNOhz12HaOB0X0vHQN0tjokISpBsjcC4Z
         cUIvyXa1gr20c1KU6sfsJ1E+TBJRuCMeuvbN7meUsNJ8MapfDgMpxnFHxHOuVQvBEbNl
         UDmysorxRW9ajqkM4yWYzW8+styFyQX0TMtLBa5vhrUHCwk6xAKLWbbFBNOTAy7iqJGG
         RGVg==
X-Forwarded-Encrypted: i=1; AJvYcCXi6fQL4NWDRJhaRi5VSHz906Xk2+AP5Bo4bbiNo9c5jhpJmLeVO1vX8x8Bijk8Mhbi+2OiCh/0maWw@vger.kernel.org
X-Gm-Message-State: AOJu0YxveQQX8RxDhAYPhlo+lgpjr/oHtxgZEhf3YEZo/sqmPdSekeOW
	dfBIPdyNTqMIQH7EgkKLiwjgNHyhXVzY9jq8Qh5GvCT195xhCwDxsAMI9i4ZZPjZcbGSR7jYIuN
	rpa+yXDxYShDNRvv5+rP7hlPmYc+sHVKAj+MAh3n9cxOHc6ysulhFcyeYeORION4=
X-Gm-Gg: ASbGncv4sAUT+0pwQy+AkJ+Klxy2GvhUxzicmWWFPd1Ybn4xJ2bH8AjfrlXLnwVb1md
	T5+otV5lU3J33F4Ts4gX2BhYpVFFUh2RSApeuz7yW9d6LWAUv/EtegRrdkty2unncoxSOh7Iwbg
	NGHIE3Bb0n7KQtDcqmcthVyhwAgijEjMAEKIeoti3X7VMCI0haAT4oK2Q8to6YAZGI4szNETaXY
	h5NYYzVSWT1GXCiE33RnG+/2eJOQsBsyUhBT5jC5z1n96oqe+i3PMeq4SHdakLHAs8emLmW+rJn
	X0dYUJIVPW8o8wIgTk5lP61yU1aW33iV+h2EU9bUFF6DU5qUacOn13rEtbWOd9gg5pEICTaIpGm
	OOodqwllFyJzy2CCbQw/cABQAWzAlKq3oQX2/GRMrhN7vufv4yWbLypjE6wcf1Poybkw=
X-Received: by 2002:a05:6000:4282:b0:3cc:19d3:8d78 with SMTP id ffacd0b85a97d-3d1dc69a1c1mr6067986f8f.7.1756724801746;
        Mon, 01 Sep 2025 04:06:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnFNLMPPscF9b/dFiH3ejH9LoyRSZRP6VErKQh6v400tD4mpYb60MjybBstgPmnFIevyHNdQ==
X-Received: by 2002:a05:6000:4282:b0:3cc:19d3:8d78 with SMTP id ffacd0b85a97d-3d1dc69a1c1mr6067912f8f.7.1756724801209;
        Mon, 01 Sep 2025 04:06:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0f85c287fsm12972589f8f.52.2025.09.01.04.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 04:06:40 -0700 (PDT)
Message-ID: <fe4bfa9d-2e1f-4f2c-92b4-7ac827ba471e@redhat.com>
Date: Mon, 1 Sep 2025 13:06:37 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] mm: establish const-correctness for pointer
 parameters
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com, deller@gmx.de,
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
 linux-fsdevel@vger.kernel.org, conduct@kernel.org
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
 <f065d6ae-c7a7-4b43-9a7d-47b35adf944e@lucifer.local>
 <CAKPOu+9smVnEyiRo=gibtpq7opF80s5XiX=B8+fxEBV7v3-Gyw@mail.gmail.com>
 <76348dd5-3edf-46fc-a531-b577aad1c850@lucifer.local>
 <CAKPOu+-cWED5_KF0BecqxVGKJFWZciJFENxxBSOA+-Ki_4i9zQ@mail.gmail.com>
 <bfe1ae86-981a-4bd5-a96d-2879ef1b3af2@redhat.com>
 <593bf6fc-bb12-42bb-b763-383ca16e3adb@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <593bf6fc-bb12-42bb-b763-383ca16e3adb@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 12:56, Lorenzo Stoakes wrote:
> On Mon, Sep 01, 2025 at 12:43:42PM +0200, David Hildenbrand wrote:
>> Let's all calm down a bit.
> 
> I am guessing you are not contradicting what I'm saying here but instead
> trying to find a solution as to the _series_.

Of course.

> 
> However, and I'm sure you agree - I want to underline my view that treating
> people with disrespect should not be tolerated in the kernel.

Absolutely.

And just to add some of my personal thought: a good patch description 
makes the life of reviewers easier. Not caring about that can be 
interpreted by reviewers as a sign of not caring about review(ers).

-- 
Cheers

David / dhildenb

