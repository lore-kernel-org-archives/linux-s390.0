Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6528332EC9
	for <linux-s390@vger.kernel.org>; Tue,  6 Jan 2026 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699485; cv=none; b=gvZlCnEJj0k+39KyAIvec9g92fCRLOqINGbDtT07OzZibGUS5mGzOO2h9D2PBU99coxhiuK4yF4CqacY0m4As/Uvf8fMKOkEmJczDR8MFrSe8ZFFMXgEpHz6W3Ru+PUblDMratItfPzFtlipQWnlUcDiDxgdMSm/fVnC+lH55C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699485; c=relaxed/simple;
	bh=U/UNWaSZOM/1nnt6plnyQwwSA8jtgy4FJfpB9IxR0vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJAN0HYCycdUJIhyb+UIeHA4RpULVoAl4gCcVqFO1Dmk8TybCtrhAqAjUlz3xnlHxJENpMMaiHiPlvKS9HzblmbVxXRcOZgzq/mTIUehYyw7q1W3nKyDLbNIwW34e7VtsOP4MXDpUgBaKH2Qi6tl3VRyIjcbHOhEdOiCNpn1Dl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiUF3LO9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiUF3LO9"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7ffa5d1b80so141137666b.0
        for <linux-s390@vger.kernel.org>; Tue, 06 Jan 2026 03:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699482; x=1768304282; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiPIfmjv3b05N/bw/XvHmU5o9/AUPMqaF5FRtYSnf34=;
        b=UiUF3LO9e5SX8lDFd+crV/iEOr46Pzj0BOrE44g2fdAsfPQD1TFBNoQRtj5gYQAOLt
         jkcAN0iz5X1x91fWE+yrR0cpIAisv1PONaSiWTBak9zpEHh7VwNUV2px/Zrp8v3oCI1q
         /qh+FZw1GyRq3nyEmay5OELa2LfkpU9r1hxd/goBFzVhDevmteHyuecF1WXucRCKJPft
         jjNejUKANHeLDGPtD4LvMbmJWv27E539ut2nyFsVUmzJAPSzsLRWDkB1FPRQhUP3fPEg
         iccA31hvM0FzTpI0928X35R3p3WSUcjw0qHzHsef3+2go2p29sq9EWk5HvlHbvYKaEal
         LVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699482; x=1768304282;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiPIfmjv3b05N/bw/XvHmU5o9/AUPMqaF5FRtYSnf34=;
        b=vpoFxMoJL7zjit6brG2SXN0KQ+k5a5OjlpXyI3QyH+hUJrJwdY7TnlLqPGuPB/Y9Y0
         FKIQEGjYaVTteRwzZcvw9hQlr3bW+TcKyhht4ZxTeAfJcS4iz9QtBIduw7BEk6Mbs7xG
         seUKwlJapALp8wIy+inpXTwckaa2pYSHFQ9s7ChmrsXionA/EycehI5rCj1JqsB8dB7S
         SzB7UvqyQwwl9lf/VJiXpa45iK7vnlF5L7CH15YlrG14Y+whPGL6YchzvC1heNDc4pSx
         3x1IAWXDTCr15G5fN8gciUti4ne5sEkSF3dsJmJGo1Q79zTx0JXXNLgAOukUjUjqFgxP
         FX0A==
X-Forwarded-Encrypted: i=1; AJvYcCVwXvN9yCTugZhKfBHiQcTnk5KIISx8Zu15aks3U1wRIncAPLey0XHuyywvlV0vwivCXTPn7LXpmHC8@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+fIDij2jSZ13QVVXCUrTppkdsALylr7RR7n7Mc0IiNpJ5hR0
	z0zWvJFvZhu50uTuiBh7W9O/OUnhQ7/BEdPWgN84ng9wK/s76MCTWi1/
X-Gm-Gg: AY/fxX5TEpUD/TWPg1UQ2KDmTs60BI+CcdtC5GnsZ43EchQ0/jwED5a8QFwILCUwsbJ
	uYeKOEFHSqeb4poCaAZxQg+RahmQM9ysKjFbSN85UpTCJWD7LR3hGwEtHhXQTcSfj9eUA4X4nAm
	VPHb31x1mjuDhfgfBgqm/PZ24AemlWBY9MRMw58FFofIjYjK0iR1KObYUpkKkd0pcl6zjf6D90W
	yR95TC2FUI/SPI+OkOrYmipPlJ718B/U1zdoSf7DNm7lCGKnFKkeMeMDGc9ixMztl1GKeK39xpe
	6Rka/EUwd+kMy+U09rwZp12S2zLXXF0fuAVJEQmnWWDY0yi9IToW7zWA8pAlKH4zJBy/rQ7THGf
	EXIfETERhRTfvBRi0OwC7nJ4dXqKvISHelCTKBDpx7rdbk7TmerKI61VLIAHAOdw/TwmFbni3b+
	NUMcuczg0C/w==
X-Google-Smtp-Source: AGHT+IE4vK7Idw33w0dr627IjMwMmN4O113exdBdmGZBRMY89j9Rrr4y7a7t8aNrQBWlB/zASfmhOw==
X-Received: by 2002:a17:907:3f0e:b0:b80:1b27:f2fd with SMTP id a640c23a62f3a-b8426c4e48emr335853166b.54.1767699481671;
        Tue, 06 Jan 2026 03:38:01 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a2bc6bbsm212937266b.27.2026.01.06.03.38.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Jan 2026 03:38:01 -0800 (PST)
Date: Tue, 6 Jan 2026 11:38:00 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, will@kernel.org,
	aneesh.kumar@kernel.org, akpm@linux-foundation.org,
	npiggin@gmail.com, peterz@infradead.org, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, arnd@arndb.de,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_gather: remove @delay_remap of
 __tlb_remove_page_size()
Message-ID: <20260106113800.rilod6iajre7wzxs@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251231030026.15938-1-richard.weiyang@gmail.com>
 <51e72690-8a0a-4532-b6a2-79a851edc44e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51e72690-8a0a-4532-b6a2-79a851edc44e@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Jan 05, 2026 at 04:44:28PM +0100, David Hildenbrand (Red Hat) wrote:
>On 12/31/25 04:00, Wei Yang wrote:
>> Functioin __tlb_remove_page_size() is only used in
>
>s/Functioin/Function/
>
>> tlb_remove_page_size() with @delay_remap set to false and it is passed
>> directly to __tlb_remove_folio_pages_size().
>> 
>> Remove @delay_remap of __tlb_remove_page_size() and call
>> __tlb_remove_folio_pages_size() with false @delay_remap.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>
>Right, the only code that sets delay_rmap=true is zap_present_folio_ptes()
>where we now only call __tlb_remove_folio_pages() directly.
>
>Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
>

Thanks

>-- 
>Cheers
>
>David

-- 
Wei Yang
Help you, Help me
