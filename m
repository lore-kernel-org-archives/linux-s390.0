Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810FE1D2F7F
	for <linux-s390@vger.kernel.org>; Tue, 27 Aug 2024 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724787513; cv=none; b=GcEDOEQJqMPg3WWR9WHiMf/MOYQfKCeWaj0yr5LHC+kuEFJfiHX+TZEy05LcTuErJsFOJEQkThmGfY4f2PeyuUJ2recC91wJsjYTGtyLyPK4dSzWWQx0u+P4t/LJyLld/R4fobxfVXCH6+d2k+iuU2k0AO7IPd7ttv4i3Xmxvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724787513; c=relaxed/simple;
	bh=GNaCMjJOc52bRuva82kV8DSjSMRFv5remTU8Dpz2wf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/luBlhzbpliWAzZhe0/Fd5+7yGw7tGv00W0sqkZ1Prnsu2nj+QAFrnlNu1uXHr+uaZuR5C+he3pCh23WamfaYTSeeV68gHIY6rHVsshmA5JGOIXPhD6mu0YY0SLPzR/VGc3w9rM52vajt86cVs4AB2EwjP7gP+0KwBiA0kZPnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=ZrNCwfIC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="ZrNCwfIC"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-203d80c817cso2038315ad.2
        for <linux-s390@vger.kernel.org>; Tue, 27 Aug 2024 12:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1724787511; x=1725392311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSfUaUduo1Pa/rzmLUTDWEfMqkYlxrVTddvKxiJfwkc=;
        b=ZrNCwfICYC/woJ6BSHsFAsoFAGz5Wvw+pjCGeNM9yKuoNu7AekJOZ7h3qzGv8RCaZm
         m1Vs7ErpVXF0Mj5/5HQNct7m2r0Ho2brQC04+cWeEMe4LICNm6Y9E7tZuMSj+el268qL
         Q5Eqi+BN6djdQimEC36K5nVKa9vfu+km+huONIKlyaJH9fExX99ny7NDy9nIYz0oe6wh
         BPattyB/JIT+sYlIsgvgDy6moTQa1CdHJ73eMKcpKLm0Bv+wYTREOWma+lMAmOyZ7pkV
         Bqp8Fvd22a5C6TmW/warkJ4VE6QmUHb3rpPMa+RWtWfL7ApjpLkwv8BL+C+E6HxIsK4b
         xgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724787511; x=1725392311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSfUaUduo1Pa/rzmLUTDWEfMqkYlxrVTddvKxiJfwkc=;
        b=Y1aptib2gOm9Q5bOLe8ziGdZrpXgDTEKmiUuFo6zYPDcsFw9J+NrcKUigzmoQX1L+v
         xRlEUowODHXShMw2fidpxoA7zawsUl+5k68dyWZVglMORB/b3yLXZVngTcYhWqiTqEXH
         PWl1vftwu84Ln8QocM/G1oC8lY/puKejs1JAKHeDkRz4RzoIwq77KuCCIphqVxdz8mWw
         P8+mFfRZuXqGBwXTZSqK9+dNm0X+FmpD17iG/na7QhfXYcCO5eW0cvwGZnWnrBuiGUxZ
         ruGBw6BtuSxTUZ2eRo2aXKa5WGYdXod5yVdU/LoJn8Opu4Je09Kbl1KpagpWXlXXIhpM
         sPMw==
X-Forwarded-Encrypted: i=1; AJvYcCWZURFP1Brai+OkqJnzFrhW+eNPJx+WnqJKf+QFFDqQsvj5Pvva7GGBu1KCN6OphIwaBCGK4KvEB9p3@vger.kernel.org
X-Gm-Message-State: AOJu0YyVFvrCuRYFvrfAyz8GPaow5okTvIVaELvGo7x3/qqUrgiO3aLg
	oUdQrxrDa6byASP6l/5HMDgv816qx48E9b+c3/J/zLXF61DUL+RWWEd6BNGjYCk=
X-Google-Smtp-Source: AGHT+IEffhoM7vcnKV0uwFl8xo1P4AX6uOPkvxejFm9AO7YhHMzJuzfYDS3jXECodlHkj1DHAR344Q==
X-Received: by 2002:a17:903:187:b0:202:35aa:c1c with SMTP id d9443c01a7336-2039e54fc21mr85641985ad.7.1724787510531;
        Tue, 27 Aug 2024 12:38:30 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:400::5:a876])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385586f8esm86554415ad.113.2024.08.27.12.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 12:38:29 -0700 (PDT)
Date: Tue, 27 Aug 2024 12:38:28 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
	linux-debuggers@vger.kernel.org
Subject: Re: Incorrect vmcoreinfo KERNELOFFSET after "s390/boot: Rework
 deployment of the kernel image"
Message-ID: <Zs4rNF9x3NUl2AkT@telecaster.dhcp.thefacebook.com>
References: <ZnS8dycxhtXBZVky@telecaster.dhcp.thefacebook.com>
 <Zn1uTZdlYNaRFUqK@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20240709212141.31160508@meshulam.tesarici.cz>
 <Zo5L9xZtIs4dCf0E@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <ZpBrDvUpn4SzaqND@telecaster>
 <ZpEyucQA1rctAts6@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <ZpE7AsR-nD2tNuTn@telecaster>
 <ZpT0loUJ4KdabiCF@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <Zsw7RU6gYHFkw9YI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsw7RU6gYHFkw9YI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>

On Mon, Aug 26, 2024 at 10:22:29AM +0200, Alexander Gordeev wrote:
> > On Fri, Jul 12, 2024 at 07:17:38AM -0700, Omar Sandoval wrote:
> Hi Omar,
> ..
> > We have different approaches in how to get it done, which are
> > being investigated.
> 
> Could you please check whether the recent kernel solves the issue.
> 
> Thanks!

Yes, this appears to be fixed in 6.11-rc5. Thank you!

(Now that this issue is fixed, I can see that drgn has some legitimate
test failures on s390x caused by the paddr/vaddr split, but that needs
to be fixed in drgn.)

Thanks,
Omar
