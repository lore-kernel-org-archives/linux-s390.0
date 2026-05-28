Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC7370D7D
	for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957401; cv=none; b=ZndstLwPX+t6sXukY6Nn3dZKhZqLKC21ki6Y6x9Ehj3098c533ykTAeetF/ZhDT8YyRyNo4iYfc2EjLgPlEFLjIYVT6AYecjgNbUiCrDgna93hp6BARSRI1ST4LVABBiQ+nUNKy2gg6KjnhMH/375/ld5R9tjLouRyoauqhksoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957401; c=relaxed/simple;
	bh=/L+6skxHoL6Cey8e8Vt3OwTrbnk5KIvRD61XNjxkfDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtPtBf98w9h55SEJnTGBkuKvX3E/d1lrrTxHfLrZRSB1UsheKh3o2WNvQuFTkDgxL6DK6Za6lCMSQPrOqF/HOgEwyXvO5R3QZWWLYg1gzszMyXPZX1cMzNOctW3WDezHMFDfYrdiD1Bygaz9KWfxCPlt81FLdaJqg4ZZ2WRH2t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCfaF4tC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCfaF4tC"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49068493267so29491425e9.1
        for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 01:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779957398; x=1780562198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1Y8/JdFuVL7cUrCqvVx1WRQXIYoBAEiRxJCQa2/Xas=;
        b=MCfaF4tCjWzTOD5y30zML5PeiXTehiMSTmvTZIwIfDAbbx4kjq1W1QEqfq1ytq0Y25
         F45iC/AfvD4ZaLrxuNXMSA5TEVSzkKNEij9TeGDstS9YTmkeSvKDdpTCocDNbcPkhivu
         C4yG6eg6M/U8dtuyDWO7p3DIaWUXl5mgBi4Pz0LjBqDgzLrWZ5NzzVHCRhGmdkpUvd3j
         VEGlKBlBOJAx+i8BdOH8whdFAegJN5VtQaXTqh2FyU2Uoct+WCGxVOAv19yJc0dKyRy2
         IwXcv62rfIRaMOHgczAaGuzaPU6ShLB/RkNGn4ki0+oMzSaSBDNNVkcfqEil8nrhcEt8
         uPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779957398; x=1780562198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j1Y8/JdFuVL7cUrCqvVx1WRQXIYoBAEiRxJCQa2/Xas=;
        b=kmT1Jf6Ki6iXdZd3Dwjj2kiaJXfpDZxUfoqZwxNiOXcbwE5qX0XsYjzwy7t1tCgg+U
         1gcM6YAAWjaEKaF1ntchzc92GTXFHc4vuTDsFEium6mNNXtDETXOybCRFrswaJXFEKGf
         C3Hn/mYuzdIORC9eVh67TaPY3dXhkrd8wNrRFmu7ftcecYFZpEw824lpoEqLQaitLj2E
         GtH2VhWhTumIH7x5Gycq7V/yQJq6ZYnnEAJPbtfUk3plDoKDcn3zbR6OJ2u0B+7Lawc+
         0Z4Sao+lGvkzBnADlEyVkrnKoueqk+aanO5aUDzvAWT1hyRxFy6O35TBjMQhJphuSfow
         5Gsg==
X-Forwarded-Encrypted: i=1; AFNElJ8ILjDleulMuAiieU0UhtlLghEI1JZcVSdF6KguG6185yz6xnMH0ybz5QUiIYslnvzRsleWHMMaeRuF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7lJhWz3FF0sA2PTcw12etLJb9l8N65aMBSit6xTcYnRPewKfi
	4dKjl8P1X83x3GLG03VHYjHoOu5x6YoFlw9E+rMBsAaSgkkBicQ/e3YJ5CTumvHC
X-Gm-Gg: Acq92OGfVx7oTcBHoeatAgu/IBydQjBKf7YUw8ueOPwiIv/hXpNq3TmhShb7ctcFo8T
	xQJh7WopGThzJmpgzPJHRpeMRNWUZd8LdglGvo88Bt3dX1p41Ct5UOj5v/neHkYnBsICsoXyGFN
	25UMYfozExNJVNTTLOZ6MBxU42coAHOJ1yQTG+Js/HWskvGiu2WgIhbGZSq70iGAH9Mu7kLsLIB
	5AbOj1jl4qygTrDeSq7vc+/bWcA/5ZXOmb/L9XCwcDFrclUkJu1eHdC82Z+EbbUuxQcOa6cjeDJ
	3S4eLBUAtYDv0s/IdW+Lfpl7ZHppqi8dsjR4kausCafNcfOaDeuh/EMHdvniO5CEa1e8wAToyFj
	fjL6oPUJ12PqaAmbZgTJCx+dtANeqp6Rkuq5oL3BTkeGa+KpR/hyqftwTyI8is6EXumuWFgtn2Z
	YH6iRf17zl66+BehV4lvbXZigPlg/otw9RBpVPp50ny3SBug4/yMgnw08CqgypX+bVUMj86Jc=
X-Received: by 2002:a05:600c:8484:b0:490:3b87:be0e with SMTP id 5b1f17b1804b1-490428e3362mr447893415e9.29.1779957397825;
        Thu, 28 May 2026 01:36:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092a9cc5dsm22994225e9.15.2026.05.28.01.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 01:36:37 -0700 (PDT)
Date: Thu, 28 May 2026 09:36:35 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, Heiko Carstens
 <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven
 Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Juergen Christ
 <jchrist@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Shrikanth
 Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 0/9] s390: Improve this_cpu operations
Message-ID: <20260528093635.314ebf58@pumpkin>
In-Reply-To: <d362d0cc-cdfc-4916-b779-fba62b3fb38c@os.amperecomputing.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
	<9d503c6f-5641-4b28-998e-01e38b3622a9@os.amperecomputing.com>
	<20260520233409.0683f595@pumpkin>
	<d8e61923-2e0b-422c-b2f6-5ccedf3852bb@os.amperecomputing.com>
	<20260521103742.9603C8c-hca@linux.ibm.com>
	<5158d4e8-19a7-4f60-b2fd-bc6bab22baf0@os.amperecomputing.com>
	<20260522091805.18098A5c-hca@linux.ibm.com>
	<f417b97c-e321-6fe7-3a7b-a3a71b16f27b@gentwo.org>
	<d362d0cc-cdfc-4916-b779-fba62b3fb38c@os.amperecomputing.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 13:38:06 -0700
Yang Shi <yang@os.amperecomputing.com> wrote:

> On 5/27/26 12:09 PM, Christoph Lameter (Ampere) wrote:
> > On Fri, 22 May 2026, Heiko Carstens wrote:
> >  
> >> Also with the current proposal I only did some quick micro benchmarks,
> >> which resulted in 0-1% improvement, which is in the expected range.
> >>
> >> It is amazing to see the performance improvements you see on arm64, however
> >> I believe that is mainly because of the large amount of code which is
> >> generated by the arm64 implementations of the preempt primitives
> >> __preempt_count_add() and __preempt_count_dec_and_test().  
> > The code is generated if you have no arch specific per cpu mechanism and
> > preemption must be supported. We have now the situation that we cannot
> > switch off preemption support anymore.
> >
> > It seem that S390 has this mechanism in a small way and therefore can
> > avoid the preempt enable/disable.
> >
> > It is not the quantity of code here. The preempt enable/disable can only
> > be avoided if there is a single instruction doing the per cpu operation. A
> > single instruction cannot be interupted and therefore is preemption safe.
> >
> >  
> >> That's a big difference to s390: for both primitives the result is a single
> >> instruction.  
> > Ok then you can already use single instructions like x86 and will not have
> > preempt enable/disable overhead.  
> 
> I don't think S390 can do it in one single instruction. IIUC, Heiko 
> means preempt_enable/disable is a single instruction on s390, but it is 
> RMW on ARM64 (3 instructions for each).

The proposed 'trick' for s390 is a sort of a temporary global register
that accesses the per-cpu data.
s390 seems to have it relatively easy because of the 8k of per-cpu data
and the atomic add/and/or with memory.
x86 has two global registers (%fs and %gs) as well as atomic add.

But AFAICT arm64 (and probably others) has nothing that helps.
Allocating a global register for the per-cpu data has been suggested.
Using the mmu to generate a page of cpu-private data would make
the preempt primitives much cheaper without the difficulties of
having two addresses for per-cpu data and any related cache issues.

> 
> Thanks,
> Yang
> 
> >
> > I am not sure what David Laight's code is supposed to do. Seems weird to
> > me.

I've forgotten what I suggested, was probably broken...

-- David

> >  
> 

