Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A08E86345
	for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626024; cv=none; b=oWv2ZAyK6upazmWAQhTC/UKrV/f4L6e1nvizzaP5qFJcs7cFMdY170w6WtKqZif9H2nVn1eeuvS+g31/7jEKp/4XRmrByea0NbL9ZEPB2u4C367JKeIJZ++IKhz75pLrJ5vQxxKoxX5a5m2Fr2ILt7hfbM76zHZ0UOSkUoEInH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626024; c=relaxed/simple;
	bh=eZxi7zGXSLGyFJ78d+lknlRIK6hiMDURb61WyxdKt/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgMUbgY/OiUbPrsbxpQJqeDQBaLCL/J279LnW5lvWZs0WfGqW4iXMVpztqwRJj7ztL5ymSmg98x9jpjNPPCpBexFBuxKKA/1eOWjrCI1nblGIHdFfvzH9YSsGSv6rDKNEjyH+3JZbL9Cu/fKLjnRPMKaD6QM71kPygFOKUPKcVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nm9lYH3+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nm9lYH3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734626021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zvs03k/uYKYzRvgsTiwrYwtB/jnLvZjQ8Cbpbwh+nzo=;
	b=Nm9lYH3+2a0vRjbxqDr/vIT3+dkc1Y77pRKvZn8gYulnhPVERexz7uSYCm9HZUvzdSJB26
	IzDpgpTT3aI2Jd6ur4h3b6bQdnYjZQFtRTRcat9+2HueQzwhEUH35rMdyOK+s29uam91n6
	ccs/jKk1GhriN/d8eEJHXxZ1o3pk0TU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-baubLA6ROzKeoEB0VuZKxw-1; Thu, 19 Dec 2024 11:33:39 -0500
X-MC-Unique: baubLA6ROzKeoEB0VuZKxw-1
X-Mimecast-MFC-AGG-ID: baubLA6ROzKeoEB0VuZKxw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361eb83f46so8138465e9.3
        for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2024 08:33:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734626018; x=1735230818;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zvs03k/uYKYzRvgsTiwrYwtB/jnLvZjQ8Cbpbwh+nzo=;
        b=OT9oCTHgW4uSB0b4OLKbYacLCS/+vSebSX41kduQnyKuEvEXXkjCssGc2tnjrIkO+n
         7OEDL7X0L7toivoDdZHoVGeNP0grGxblyPyZD8JbX1NKoQP+jo7HEAc0kRNQC0bTxK+O
         nHH0Tb4JWse6PJaWtz6ZTOBfB8thoMOeG0yirGxT3AFjAmVMsIiLmHaQpCyBOpYugW0t
         TRIfzEZ1dZWT7vb+GlzWPZTd6SCW/npPG9F7as2r0vt4HOqt8z0aP+Hr2WOtdKUHvh2k
         GxHCzwdWgyAygfzBSzAxn0svrALOr4w/70IoHm4IpgYszG3EUgUBoMdoegC23iX0jhgf
         PFAw==
X-Forwarded-Encrypted: i=1; AJvYcCW+CTTQz6NoEKRFMvOZGB4eEnu6oQYDfgnGzCg8lKFsZVfcg9QxgMzY+PnaEMsuSvnH8J9WI5TLN7ZW@vger.kernel.org
X-Gm-Message-State: AOJu0YxUJCalNF4ywqak5BhPbaXdFTp/KWjv6aXNcLrqlIk7BKiX6k4H
	jlVzIkllXiY3TuUrTxFwcYujVkPI71yVHzFlm3Icwq4BvlSC9jsbaJM39g3jjRRCJBBAK8ss6gB
	LstvNLH0FU98GpYYKnxRWd8aHrH4NJyyHFpBhfNRjxVHb367C03t/QHiUPRDJAgevLtwurg==
X-Gm-Gg: ASbGncuaEq0TjQaI62L82SCRle2Gp0mxKK2sEExWGm7ghqYW2qujWVvnaK8Q0CYFTnk
	wzBZ5Zt3vS7MkxVCyLNT7Y+Frkk5PMf6NI2TOCTs2S2Sbt4KYvnt586sdqeRzz8fCTQ6+HvdPC4
	oPS3vGpWyhz29fAnoaeLEWrG822chRdgO82+nPQjsqJlhxrSpqN8itpGSB9bg0EHdAz0r31gVen
	8AqUI5X4TPM4WnGMKldkoQLYIErETnOzeEaAvuVGcS1Eo+RsyZoufY3SLZ1OvQSgQUUMC+tlPbv
	Oz5Gg8YFMroikbNhOiWKTOoaFCXHHD+maawRB8kmpz33wd68bPpmTgCySSEDuvjOrS7saUOmweq
	L+yaaaQ==
X-Received: by 2002:a05:600c:474d:b0:436:51bb:7a53 with SMTP id 5b1f17b1804b1-4365535eb12mr76142875e9.12.1734626016802;
        Thu, 19 Dec 2024 08:33:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIIQCQzshqZveCz1h77eyQHrJ+9WTT1fkWgArDXUuAUQTt0IHVhSZDzEwkmGHcwI0J2lXyRg==
X-Received: by 2002:a05:600c:474d:b0:436:51bb:7a53 with SMTP id 5b1f17b1804b1-4365535eb12mr76141445e9.12.1734626015619;
        Thu, 19 Dec 2024 08:33:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c749:6600:b73a:466c:e610:686? (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de. [2003:cb:c749:6600:b73a:466c:e610:686])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364b0566f1sm63635575e9.2.2024.12.19.08.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 08:33:34 -0800 (PST)
Message-ID: <9d4efc2e-56d9-4786-9ccb-ecd15f34f3e7@redhat.com>
Date: Thu, 19 Dec 2024 17:33:32 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] s390: Remove uses of page->index
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org
References: <20241219162252.1025317-1-willy@infradead.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241219162252.1025317-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.12.24 17:22, Matthew Wilcox (Oracle) wrote:
> These two patches compile ... I can promise nothing more than that.
> 
> David suggested to me that the gmap code really should be using ptdesc,
> and I think I agree with him.  The vsie code looks quite different
> and probably shouldn't be using a ptdesc, but we can use page->private
> instead of page->index.  It's not yet clear to me if we'll ever manage
> to get rid of page->private.

Just curious, does that mean that memdesc would always contain these 
additional 8 bytes?

-- 
Cheers,

David / dhildenb

