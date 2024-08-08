Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4132770E;
	Thu,  8 Aug 2024 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723127050; cv=none; b=bkcU2YOD8vlVUJSk+JchkAAzkpKvuRH9P6O7JaxIGNdoWwCdcm3FyRN4ech0s9gWi/XAPJsfFUSqfPEQuIgVOYhIPvSlv6xnZViqDkptgfN3W0R+RmaF/gA8dcKbbHMBg3YxtpmmqXQ0ZIcOICmtCZow+Rx91pDfFscHBYfZLEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723127050; c=relaxed/simple;
	bh=rQPaIp3gvnKwKfiqvePOZNVA8JAw1Wkt4p/m1gvKaw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqocDkX1xeRlOF/XILtzB0AJak+PgbdscqwNlDWsodFoSMHyLlAbnGplFU4J/3ggm4xFKS1CZgVwWSpdFEbYNPAjlXa2QD1HuAphuAP6h7iiK4n3wSGJuDgREt7bn8qTxzDFe4dY6TKxHtEfoSUIELQRz5udVm1kQgnIp/8RtWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJIj9B1R; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJIj9B1R"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso1097041a12.1;
        Thu, 08 Aug 2024 07:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723127047; x=1723731847; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwycnN0pOkHu6v/Wf/jldzzdbOFGNUEkeQ9Th2/NQ/k=;
        b=YJIj9B1ROlIyVwnHpiD9Xf274ZdsAQGXytU/uS3unuWwHLflDKixniOCrrx5jMNfED
         D8PiqBsArP9KnB2afDpHDGfH/DHtBmaVKAq/RmTjrIaVazZMHK3bX+VQ+DuDHkQo2OFa
         t5un8r65lN6Z6RIZz0cQ8iniRfwzT+D4I8IWL6flAWjOwrDbgSobuwpWEYT3uh3OoxRu
         ZjTOUzqidxuUU+3qRJBmSPsRKrseUUGbOmQKcQsutlikL3brTy/H/ES5krRBty7DZT78
         HvfSIdJ9iNJ7ulMrU6pkgJLhhnIj+UjIb+3K0gIlzmTFA931LRu7XonG8n11BBqzrvxC
         q4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723127047; x=1723731847;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RwycnN0pOkHu6v/Wf/jldzzdbOFGNUEkeQ9Th2/NQ/k=;
        b=P63nYuMs/nqoQSz4Uf3Tw4rAx/95bt/oPxf35XZWX4nSV2ICAeIqU0kDLju3eIO/ws
         75x+k7sP0s2T3cOBb/9yaIoeeIQHSIesr3g5+gB0cfCyV0W25303yh4nzCqoB25vlmI1
         9jYI/If8OwN5LhGmXd+TvYPErxE0yGq8OTKT35LRolEQmhNJX8i+FJKB36pJDeop+U1D
         kE7cY6eqKhP2P6elxNJOHrwmO3eWNL78L38g+v0xv4LagLutjj6nwYW/EHjSvsRxzYOG
         KMApsWIHcGV9GCCIbjkJsDzZq68TbBP636OFbrSFGNRcUlHdrhsKqm87JUzH47DTO7Gl
         Jryw==
X-Forwarded-Encrypted: i=1; AJvYcCX+3walGzgncUs+61ur4XtqA11e1Y+itQXAB+nv6rfptwM7RGM3y4KCGdlaXxSRd7vy3CL0zLAV4eEKZYJKSEkkYbSUqOzqvoxMjgyyB4ye1u7zuL3GhB5eOCoZp4c62NBNkP6mf1hjtw==
X-Gm-Message-State: AOJu0YzkmeDVsslUoxkm1J24zK71Ppmy395P5+/GwyDqdpVR3ztB0cE4
	edx6ZSX50rZ9l65T/MlQC6wXtMuj7eAkkr6N54Hf8t/zD4PKc8r5
X-Google-Smtp-Source: AGHT+IGAINzcfiz5VbZvk6czh2iTO/zbsODVhNEtsHllWPWdBHr1pJaKrq/NQVeRwkMi6E2tT4xUfg==
X-Received: by 2002:a05:6402:2708:b0:5a2:189:6306 with SMTP id 4fb4d7f45d1cf-5bbb22330a3mr1890210a12.18.1723127047008;
        Thu, 08 Aug 2024 07:24:07 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c6f6ebsm682635a12.56.2024.08.08.07.24.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2024 07:24:06 -0700 (PDT)
Date: Thu, 8 Aug 2024 14:24:05 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com, rppt@kernel.org, akpm@linux-foundation.org,
	brauner@kernel.org, oleg@redhat.com, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 1/3] mm/memblock: introduce a new helper
 memblock_estimated_nr_free_pages()
Message-ID: <20240808142405.ttlcfkximywtde6i@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240808001415.6298-1-richard.weiyang@gmail.com>
 <ZrSYruB/Aa8+oBoZ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrSYruB/Aa8+oBoZ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Aug 08, 2024 at 12:06:38PM +0200, Alexander Gordeev wrote:
>On Thu, Aug 08, 2024 at 12:14:13AM +0000, Wei Yang wrote:
>
>Hi Wei,
>
>...
>> + * Return:
>> + * An estimated number of free pages from memblock point of view.
>> + */
>> +unsigned long __init memblock_estimated_nr_free_pages(void)
>> +{
>> +	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
>> +}
>
>This could possibly be short on up to two pages due to lack of alignment.
>The current uses are okay, but since you make it generic it probably matters.
>

I don't follow, would you mind giving more detail?

>Also, the returned value is not an estimation. Meaning the function name
>is rather unfortunate AFAICT.

From my point of view, this is an estimation for two reasons:

* value from memblock_xxx is not page size aligned
* reserved memory maybe released during boot stage

It is not that easy to get the exact number of free pages here. Do I miss
something?

>
>> +#define PHYS_PFN(x)	((unsigned long)((x) >> PAGE_SHIFT))
>
>Thanks!

-- 
Wei Yang
Help you, Help me
