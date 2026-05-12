Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F771D7E5C
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571923; cv=none; b=tByxgKyMT6Kn1feZ0ZNqpRll7UacCPrQTOBdL0qYks4KYcry1ac5FJJJW0LZ6Rh8W3KpU6e6cce9fOhzHD6UEzWyGHYZ7Il30Emk13OTBWBszRkaKCHXep0gk0F5cHkVCcDziKFc1MOGUGTmfANOM3QeFZHqQ/wgkASp0BRWcvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571923; c=relaxed/simple;
	bh=f+yWQMRJhhFmv3gWuRjIuOMLgbpJH+o6i8+Glu9ZEP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1G9GXqrSUZdPtas8/+olc7sbSTEx76r9vS+nXnVXvGU8W+9qUfRAjzcid7aRVvGb1Hy/2j9H1XZCjBWe0MowRmxYtpaBgbkFW4w0AAqNMMqkycAzUhjWcFpoB1eKyBjSGc9gs9EYTjIaYtqeNvH/wx1JtE+meZjg4DMARl5HeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xn4hnga/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xn4hnga/"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ba840146so45992525e9.1
        for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 00:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778571916; x=1779176716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YuUpqcwRSMeMl5pOLaTVyc6TdYwqJl65snzBr5xo1y0=;
        b=Xn4hnga/P7L9YXCppEJLnBL4DfcInuCK+mZ6VABAT1nof0/wIln8cBcgJKclKcd9YQ
         KfJ3wGhIA8F4oBkcCh7eVsAim2f3gX4XvPyGKr6rfyZk7tkIq5EkAsr071pfXmVgJN1T
         bNPuJ/EWJDz3tKEz6dMWC8g23iS/w+hEFm/rWjoFVzJ7sbmR/lRgZ9ZNWvm7Rhle6o0O
         AwdiOdCzldL/YoefkXrmaGEoDesANSIGAcD0zsc16NC59tnsWKxZmicyE1SkWMrT6Ypw
         7er+j+tt6UcCeTq1nJ+TGczD/rdw0PvxTkLW/abwwArRe8G37EIKYmD1Cl9lRbRvKNSC
         YRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571916; x=1779176716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuUpqcwRSMeMl5pOLaTVyc6TdYwqJl65snzBr5xo1y0=;
        b=VPX7lHEchUQJs7mLjh4OJ5OV12WlzFBk+Ep5QdiumOklMHv4Rg0AgbVfiSCxzjGkIj
         Ps8xlJyhbn28jzK/0GYQwJqdqAiXeHAfeKWOx70oInYPmUdXbqbEZGRqjT1sZ6qcnep+
         H8jBB38S7+rr5xGntbTYB3M93BCBJ6ls96brzYKagLug7roWw+LXnSmfOowo+ouk0sb4
         Gt3SK/HS9UuWMVBTfCtt8vcUaD0TsEwQ6zooWo9fV42fzt9UDxpkS5e96IlEtLbZXuD8
         TQlpynIkHBO0VtgESze033A+uQ4QHiSQQ6Njdu0mAHTKmPFT7058K1iThLVTQ+dl6F0b
         9eZA==
X-Forwarded-Encrypted: i=1; AFNElJ9MZ76gDMjXOfBDZUIrC038IVrobfNkh8eyPjnv9XRTqlMW8CRPkO9MM0cz/56KYVAIW4YWZSCT5Ymg@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu9tSoCB0Q5Y2/FHyw5x53pgJOX+59h5VLUxrBPmF55rc1GU1C
	PzS9WI8MjGXLlg1/+yN5pSfqvW/JFAW83C9fPMpPyMr3xy0/OKFek8ibnRAmrG6z7LE=
X-Gm-Gg: Acq92OFoTWn5/4H+Yyq3fWLwun+OeJ8thJXc1CEvvL5+Gjbl/30RgVCwsDQmD3K6pOD
	8TGop/vJFpns2YWqi/9x1YPqYOHmoAcvMnyb2fDHT9diMLUTaHk2GyADxIr+u+sosxxwyOrqI6g
	hjNr3t8VKhg+/ITEsZZGnq13H2sDnaUuHv+GJvPJIrpNoV618p4l1C/fG2BvYOHG75UDzdVUNTm
	wIYFI9yNYyeegHwP70+ai2em+Os0Q1pTrigyTJ/+QF4ZoDNsPnldlFRGjHSSFwhhWpJ0i8Qtygs
	tGhPvD7eTt4iwgcr22IpVnodZafAQWjCcuzk9vuN2Jg7gjmG5U2rG59je9a7Rnox5ZNp/5X679E
	cKWv0GjThHOFqE4TZBkIe6bGsB+dqtVDPH6mXYRxdze1ZmmGvI9QLGs0GVSHPzagXK1e1tkVfPd
	+kjjWtRI4cP7KumK2/BubihulwdePe3BRQ/euf
X-Received: by 2002:a05:600c:c058:b0:489:1aed:1658 with SMTP id 5b1f17b1804b1-48e8fe7b8bemr18623855e9.23.1778571916418;
        Tue, 12 May 2026 00:45:16 -0700 (PDT)
Received: from localhost (109-81-80-123.rct.o2.cz. [109.81.80.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f63beb7sm13428995e9.35.2026.05.12.00.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:45:16 -0700 (PDT)
Date: Tue, 12 May 2026 09:45:15 +0200
From: Michal Hocko <mhocko@suse.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/8] mm/bootmem_info: stop marking the pgdat as NODE_INFO
Message-ID: <agLai5lr0CQRZLBK@tiehlicka>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-5-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-5-3fb0be6fc688@kernel.org>

On Mon 11-05-26 16:05:33, David Hildenbrand wrote:
> We removed the last user of NODE_INFO in commit 119c31caa59e ("mm/sparse:
> remove !CONFIG_SPARSEMEM_VMEMMAP leftovers for CONFIG_MEMORY_HOTPLUG").
> 
> But it really was never used it besides for safety-checks ever since it was
> introduced in commit 04753278769f ("memory hotplug: register section/node
> id to free"), where we had the comment:
> 
> 	5) The node information like pgdat has similar issues. But, this
> 	   will be able to be solved too by this.
> 	   (Not implemented yet, but, remembering node id in the pages.)
> 
> Of course, that never happened, and we are not planning on freeing the
> node data (pgdat/pglist_data), during memory hotunplug.
> 
> So let's just stop marking the pgdat as NODE_INFO.

With the last user, shouldn't we simply drop NODE_INFO?

> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/bootmem_info.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> index 74c1116626c8..cce1d560f094 100644
> --- a/mm/bootmem_info.c
> +++ b/mm/bootmem_info.c
> @@ -62,15 +62,8 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
>  
>  void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
>  {
> -	unsigned long i, pfn, end_pfn, nr_pages;
> +	unsigned long pfn, end_pfn;
>  	int node = pgdat->node_id;
> -	struct page *page;
> -
> -	nr_pages = PAGE_ALIGN(sizeof(struct pglist_data)) >> PAGE_SHIFT;
> -	page = virt_to_page(pgdat);
> -
> -	for (i = 0; i < nr_pages; i++, page++)
> -		get_page_bootmem(node, page, NODE_INFO);
>  
>  	pfn = pgdat->node_start_pfn;
>  	end_pfn = pgdat_end_pfn(pgdat);
> 
> -- 
> 2.43.0
> 

-- 
Michal Hocko
SUSE Labs
