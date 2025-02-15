Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9191B2907;
	Sat, 15 Feb 2025 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739622721; cv=none; b=CuXmP6hboTfjaT0ghD4O9mk1owPTm1kJaxTHmIDCTwzgHcLJuvULhyH/rkE/2TcKjfOYQhtB52dH+J+NoBx/Mj4CFFH5O33Jh68i6Sgmp+cQR2d5OWXjLQzyjAwsWuUhFxfsffp+jlruN4pDLTNlwz2I8xtkhm+5xQk3tpVQ3dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739622721; c=relaxed/simple;
	bh=D5G0HKCIPWKSJTETYd0WNwsmeh6SEjTMIoteLitYD10=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HG7JY3P5QVvb/yx4/Z9/mw7RYJ5pssUqykWq0uOpl/Tx1PoCjG951SumNOYIajtYxKpROSJ2ZzQEWCUBVp0Gu2G2A6pZxiVnjM7VUwS6/CfeP8+ODq5kT/52EzoOhU0YEXTvGk7YP2LuQ37ssp2XS4VFea4V1kG4mVCMEX2/z7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2nsSlZK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2nsSlZK"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so1658101f8f.2;
        Sat, 15 Feb 2025 04:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739622718; x=1740227518; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ooQbejPW2H/DhzcDw7Zh86TF4u7fsUqvHl4nGqSelPw=;
        b=j2nsSlZKvWzabz4COKpFmFn8sIk/BxgFgJo77PDTj7pXKBYwK/jyyiNPt7OYTP/5t3
         xhHJdZO1a4wvMgS1gjOlOy3PLCgyb3YpvVqZSYmT3kEy8slVe7lrJwRLrmYzzH5yFjth
         4k6k1PFpwRcquZKgKSq4Tc/vMcq12RQ8wc71BEvlx3Rg8UQyO8SvtEkUZdWNr43qQUs3
         swBz03RlhYz3Z7EITl+LNzvEjH5IKGuNyKmzWd8/hPeoy600f5wnAE31CR7/gtXNaOOG
         2F8jhdHsQHZH7us7M3JwTfaSYO1M3mV++NmsqQCEb4YpPEtbAidSpKG5uYcERgeUASYa
         Kr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739622718; x=1740227518;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ooQbejPW2H/DhzcDw7Zh86TF4u7fsUqvHl4nGqSelPw=;
        b=ACMKnVW77pRufCM4DIsDnoeUBgyaLOEcJs/8WgHutnqk8nhllA8aUnzLfylIVxIpef
         Vo9xPfcUodqfc3zohu4abRP+dua+IWjCVM6WELscteK0zkL6Jl4mTAM9UUQslgcUVtbY
         DeSWVVp/em4BzKI4VPDDcFe0dXQaUveBx38XPvYca4ks8FIP1cTU77X9WAUzh5LIo9IY
         OcsIHCR6EJI7nzQmSh8UtuTEnzR6J3Mfeszgu/gPOpm/thquWBL1hEqvb6m6KQyaS1Bm
         IJhMbcm04u1JjebsEI6SvG7yKicJ7t4w06zAWXoq/nPli36kGk/k+B5qwHAm1F1v5tX0
         5HLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjlMJWPlaCzZJr9GOl7dak1hLDXtkjuWik2w0vaKcIAj83wSr7tGgaKQx6Mo9pLViuR3anLN18r+mgTA==@vger.kernel.org, AJvYcCXQqlcL2mcCpTZ/Ip+Jt8NjVSoSv8wxmULpXQ+z2Q4R6p62wPDIkHRoMWED/3cdnpL8b2C+FVj30cMgcTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcly85Bp75FhozTxjKVb5FAQo9T3LxmnRL+YujLIBmUVBsFtNa
	ad/SMfo4bl2qS4TZ4PW1jWLzhiMzpNO2hJQ75B2m7iBTCzwW+v+QrjhuQSTr
X-Gm-Gg: ASbGncsUdqgntm91i9N894AG4YjveD7X8hZl77iJ8rmVlhyEmkWwnnzUEsNNYWp3Lge
	L2+8QvQq/eKY+qoO4BrNigwxYcZRSf2YBWCTuyi4zHatLvqu96QrnbA+AJXXcvPaH2IvXT8i7HM
	G7I8pM/7n1B6pIGClkt2zxyDUg6SAVxdSMlkR24++BQCev8iu3MyLcwK0z7QaVvbsRLQUdzY8uX
	miSS27Ukb03VQvjId67Gj0b1WkLZ09YbECSLkOfof4CDz4Wu2nelNo6XJ0357cdQyRkCHjQ2SUO
	3u7GaTWuHpBbf0YD+g==
X-Google-Smtp-Source: AGHT+IHm1UUnP/9Kpbsqv6esXi7Vk5bcRZRymvEgoNah7y4zKMlfpz3jf1jZNPdO+LgjakvmZhCvDQ==
X-Received: by 2002:a05:6000:dc6:b0:38f:3015:b9f4 with SMTP id ffacd0b85a97d-38f33f337eamr2637765f8f.27.1739622717423;
        Sat, 15 Feb 2025 04:31:57 -0800 (PST)
Received: from qasdev.system ([2a02:c7c:6696:8300:25c:5fd7:e9cc:160b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65bcsm7173950f8f.65.2025.02.15.04.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 04:31:56 -0800 (PST)
Date: Sat, 15 Feb 2025 12:31:45 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/mm: Simplify gap clamping in mmap_base() using
 clamp()
Message-ID: <Z7CJMfywZ8HoqbnL@qasdev.system>
Reply-To: Z68h0B6vFdfCbNpb@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2025 at 11:58:24AM +0100, Alexander Gordeev wrote:
> On Tue, Feb 04, 2025 at 04:25:08PM +0000, Qasim Ijaz wrote:
> > mmap_base() has logic to ensure that the variable "gap" stays within the 
> > range defined by "gap_min" and "gap_max". Replace this with the clamp() 
> > macro to shorten and simplify code.
> > 
> > Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> > ---
> >  arch/s390/mm/mmap.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
> > index 76f376876e0d..a3d3e09a2828 100644
> > --- a/arch/s390/mm/mmap.c
> > +++ b/arch/s390/mm/mmap.c
> > @@ -63,11 +63,7 @@ static inline unsigned long mmap_base(unsigned long rnd,
> >  	 */
> >  	gap_min = SZ_128M;
> >  	gap_max = (STACK_TOP / 6) * 5;
> > -
> > -	if (gap < gap_min)
> > -		gap = gap_min;
> > -	else if (gap > gap_max)
> > -		gap = gap_max;
> > +	gap = clamp(gap, gap_min, gap_max);
> >  
> >  	return PAGE_ALIGN(STACK_TOP - gap - rnd);
> >  }
> 
> Whenever possible I personally prefer branches over ternary operators.
> But if one wants to clump it in one line, then gap_min and gap_max
> are also redundant.

Thank you for the feedback Alexander, would you like me to send a v2
patch without the gap_min and gap_max variables as you suggested?

> 
> Thanks!
