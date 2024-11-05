Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E08A1CEEAA;
	Tue,  5 Nov 2024 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817283; cv=none; b=rRHLa+T/u06L1hmVYP0MeOCZUWXVlGJtL782Ojl4AMvuH1CNc9MUVkN3JtH/+Zfo8UkwVWFmM3k3IOBhCFRGLkVI5t9aw/3jvZQ9rzBEdDRPmChblf3XU1kUM4fGVmfjGafdDJMm88iWdGmRyObKfNeYEr6QFm1/YKrb4Op0LWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817283; c=relaxed/simple;
	bh=JXYG8C8U8PK2PfTzjVVWzxODStkLS87k+WMOcY0Y+rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyCtjf6QURmCgSYcOiOyXyYmU1dIo9XhMne/MyTq3G6afTwnvKEFVZX4kIFp2y4blNljXtSt1XDxAtNqMh9rWyGsFsdRk0i0sS5c4fbeTKRHN5XNZGZrPE+PSndCyid+MZ1UFnfibAcYc2rAbd2RSJsfz5fAv/eBiJnqIavpNpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H5BwgpdT; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H5BwgpdT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730817276; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=VqUIx8YOuTVgTMRjLpcD/6mYu4oJpNJNpPHrEV3XDtI=;
	b=H5BwgpdTcQw90/xTZQJdDMQXfHidi13xSv81ueowdGn8XK0NoSH/adtcePCXzc33+gqlv86s7437V0u8NANKLMIFE2O/QXXrGkei3Z5kAdpYGfXFoTGy6vuw9D1vBZdlQuvyRAge2DO8R3VnfNh19RVdnDgrCSOwO2ARaDoZA34=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WIn9yom_1730817275 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 22:34:35 +0800
Date: Tue, 5 Nov 2024 22:34:34 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Nils Hoppmann <niho@linux.ibm.com>,
	Niklas Schnell <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>
Subject: Re: [PATCH net-next] net/smc: increase SMC_WR_BUF_CNT
Message-ID: <20241105143434.GA89669@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20241025074619.59864-1-wenjia@linux.ibm.com>
 <20241025235839.GD36583@linux.alibaba.com>
 <20241031133017.682be72b.pasic@linux.ibm.com>
 <20241104174215.130784ee.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104174215.130784ee.pasic@linux.ibm.com>

On 2024-11-04 17:42:15, Halil Pasic wrote:
>On Thu, 31 Oct 2024 13:30:17 +0100
>Halil Pasic <pasic@linux.ibm.com> wrote:
>
>> On Sat, 26 Oct 2024 07:58:39 +0800
>> Dust Li <dust.li@linux.alibaba.com> wrote:
>> 
>> > >For some reason include/linux/wait.h does not offer a top level wrapper
>> > >macro for wait_event with interruptible, exclusive and timeout. I did
>> > >not spend too many cycles on thinking if that is even a combination that
>> > >makes sense (on the quick I don't see why not) and conversely I
>> > >refrained from making an attempt to accomplish the interruptible,
>> > >exclusive and timeout combo by using the abstraction-wise lower
>> > >level __wait_event interface.
>> > >
>> > >To alleviate the tx performance bottleneck and the CPU overhead due to
>> > >the spinlock contention, let us increase SMC_WR_BUF_CNT to 256.    
>> > 
>> > Hi,
>> > 
>> > Have you tested other values, such as 64? In our internal version, we
>> > have used 64 for some time.  
>> 
>> Yes we have, but I'm not sure the data is still to be found. Let me do
>> some digging.
>> 
>
>We did some digging and according to that data 64 is not likely to cut
>it on the TX end for highly parallel request-response workload. But we
>will measure some more these days just to be on the safe side.
>
>> > 
>> > Increasing this to 256 will require a 36K continuous physical memory
>> > allocation in smc_wr_alloc_link_mem(). Based on my experience, this may
>> > fail on servers that have been running for a long time and have
>> > fragmented memory.  
>> 
>> Good point! It is possible that I did not give sufficient thought to
>> this aspect.
>> 
>
>The failing allocation would lead to a fallback to TCP I believe. Which
>I don't consider a catastrophic failure.

Yes, but fallback to TCP may be not the only result.

When we don't have much continuous physical memory, allocating a large
continuous physical memory without flags like __GFP_NORETRY would cause
memory compaction. We've encounter problems before, the one I still
remember is the statistics buffer for mlx5 was once allocated using
kmalloc, and it was changed to kvmalloc later because of the large
physical continous memory allocation cause problems with online servers.

>
>But let us put this patch on hold and see if we can come up with
>something better.

Agree

Best regards,
Dust

