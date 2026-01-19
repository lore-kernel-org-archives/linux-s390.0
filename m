Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9092DE70D
	for <linux-s390@vger.kernel.org>; Mon, 19 Jan 2026 05:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768801072; cv=none; b=VXR/JBLQ61lxO7xvDhxsWIDuW5D8Bznp8kP7rzwnzfPMTWRdowrDzuaxgJZJNJEyN0nyMeAug5uGe5eZFmc/otJYcF4CUZwDPB3pRelgGRH+k/KUNIh1KTjnnzFp6kVL8uvTjPZGur854jmbTHx4oZTNhL2tEdvlr8fbKBx00TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768801072; c=relaxed/simple;
	bh=kpZ6kpUv/7LKQiaUs7sFoIfYQd0e2AXe/uijT3vOfW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEHALItCSqUsVscSa1xAfQnsGmE94wLoqOh1sSqydN16L5lAVAkdGU8sGnNsqj0Rtwa+Vkk/3lN64F12eo3aXrA717qyh6sDGjvg1/CPmJR5VM7VG52Gi7sHzRyS8zgNVQ5ONhrB3m8oBJPtLSFPSvBkeI0epT/FfEMnBTEKoeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aN32r5M0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aN32r5M0"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a081c163b0so21270615ad.0
        for <linux-s390@vger.kernel.org>; Sun, 18 Jan 2026 21:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768801070; x=1769405870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rV07savPRO0IKbzKw21+aHwR+cCqLisS1/gIxq8rFVs=;
        b=aN32r5M0+IYay5flQUpiovdjwzlOwX4ikkWLriAJV5DLlcr7Th5sxrXH+SLd2l40YE
         4j27zrpyKMso/mYQch954DuE9KUOlNTNUU5J7UiUvUEeyFzIw1fND1KzwVuK+W/BiyY6
         KisfHfjJaPn7l99XX0UIkWgZT9rBOqDCiLF64k5hnxGXW1ZS++lC0cfM00gcL4JjQVko
         RwY3kNa9F02BX37gxGKUSAP6uTcL+eEDc+AnMxz+tDXTzEk4NgHcaBZgTWMc2M978bRU
         hr7FqIzuedrjPNZE3OLHJy726Ncr0aPTr7GuVZLlsLUS06dIFdXGgMgFw9LNMHKqztNm
         gXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768801070; x=1769405870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rV07savPRO0IKbzKw21+aHwR+cCqLisS1/gIxq8rFVs=;
        b=xC4xtCSok57T6iWD4KWSA9lGRMsRYoEjnIcWCR18+0wyYViz+ciNVOtn1Fs297ngv5
         mJXUo3JqTH3u4DSXtsDQvCD3CXO3Bx25YHaa4RSBFjzxAE679SyndxEh+/yeSTVlpUcA
         Xr58KQg5wKejjoNdDX0QOrEbhrJ3ZpCQWq7D1jGXuk0ihBj2io29UPG5A9Qr+6U9NE+6
         UerAMorD2hIny8Co8slztwYVvaGg07uUD7Kfwp1rgkJrMJ9o8BHY6qQQTicYSqORpSCj
         T66IFTHwpuOGw/oDWNdL/Q8RTLgeW2ZxNQNbPNNMVSPrwuIdRDiJzUbSs6587DAgcOou
         Gl5w==
X-Forwarded-Encrypted: i=1; AJvYcCUaKLljGWpcJRoP3QPhIe83KXVMulOcJChFSDue8TqcbRZAd9TffFgwC/IatgxFEn7GIKSBrHM6A6u3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2z/xFf4btvNttmUILcAHQQqahxuXud/gCdO2aDX6n63Qtvo/Y
	eXYz+2bx+BiEgssV0zJG/ikt2yKxqtnKVLLZiYxQ4UbxbCtxhUfYtGNlgrT3+pEO6kt0MCkgdCn
	/PlL/
X-Gm-Gg: AZuq6aI+DwGBmNqvMtherWfuhiwaXlfkKx0q8EUAwppzn8WX7cKiP7aYFnFpmkg0e/i
	HqIDKZv09zEUMB3uujebaTUvJKa9yWullilvHE1WnCg7QxRuovel1NAnVjCiPAisdq8w9MKeSrL
	N3dwYnLvJ8/eTGR1IOrrKslZ7Zbg6B8PL/Fc6LrZthdY6ByRRQn84bj+s/BROEXbbwRFN66Yybr
	4ThHJ/JrHmiamTVI3ofsgdr8q6SZT0jiy+QXYZa3mo4n7A+PuoMQ2wguHX0fT9EEllawnu3M3LP
	t+Qh/xidaW8hUSb7q3ulTDcJZ0ES1V4USB287CvcupVYfX955c8pifgaaz5QpBgjAnGCTuZ/B0M
	M9RJOiPUOJeiJsnT9WcVfjZS2rRk+Dxkc+pLOZLbQ6LSbOZxhVh1sZiUhN6MxYmVXoY/b5sXGPV
	V6VH3qzFS2geQ=
X-Received: by 2002:a17:903:28d:b0:298:efa:511f with SMTP id d9443c01a7336-2a7176c5c7amr104119265ad.39.1768801070083;
        Sun, 18 Jan 2026 21:37:50 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190eee4fsm81033725ad.42.2026.01.18.21.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 21:37:49 -0800 (PST)
Date: Mon, 19 Jan 2026 11:07:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Kieran Bingham <kbingham@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Mel Gorman <mgorman@suse.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, Valentin Schneider <vschneid@redhat.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/15] cpufreq: ondemand: Simplify idle cputime
 granularity test
Message-ID: <rnnx7nges4otjixz4n62q7vtgrdcphepbkpmdntupbdft2yvi7@b3ong66tikoh>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-8-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116145208.87445-8-frederic@kernel.org>

On 16-01-26, 15:52, Frederic Weisbecker wrote:
> cpufreq calls get_cpu_idle_time_us() just to know if idle cputime
> accounting has a nanoseconds granularity.
> 
> Use the appropriate indicator instead to make that deduction.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index a6ecc203f7b7..2d52ee035702 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -334,17 +334,12 @@ static void od_free(struct policy_dbs_info *policy_dbs)
>  static int od_init(struct dbs_data *dbs_data)
>  {
>  	struct od_dbs_tuners *tuners;
> -	u64 idle_time;
> -	int cpu;
>  
>  	tuners = kzalloc(sizeof(*tuners), GFP_KERNEL);
>  	if (!tuners)
>  		return -ENOMEM;
>  
> -	cpu = get_cpu();
> -	idle_time = get_cpu_idle_time_us(cpu, NULL);
> -	put_cpu();
> -	if (idle_time != -1ULL) {
> +	if (tick_nohz_enabled) {
>  		/* Idle micro accounting is supported. Use finer thresholds */
>  		dbs_data->up_threshold = MICRO_FREQUENCY_UP_THRESHOLD;
>  	} else {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
