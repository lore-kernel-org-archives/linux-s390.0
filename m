Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331C5284B3E
	for <linux-s390@vger.kernel.org>; Fri, 29 Aug 2025 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454013; cv=none; b=ZWAAP3GGioVO8G+wcucOjhfZmQSDwE1ATn4qo12OfHo0vwMU4SUYWO6JeKgQljcIHUZt98gJB37SNbxkO3Wu9TsZSlln3pP7zHLqq1PdEf/sDMHoKa9Efbs7FEjmxgfAu1fBF8JB5XnSOuga7Kr6EQpevJ3CkrNYw3pS9ojuO5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454013; c=relaxed/simple;
	bh=hd/Q4wK5Af44IVTmRDhb0IMpmen0zove7usKL1pLP5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QiDZBaiDwwH0sKxzICnbnRNgij8ZiPQRBwHBOys0Ue88Xhirfp1OrimYXYS+71vP6PLhNzPx9CzzGJz2E3kIV6NKkErwDZyPiFknsvSUs2tjlFSHGm3XBWB6nZ9XHTOPngaZi7dOViDrV0UFTaqNa+MbD6tsNUkSPaMWHU7NeVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNNd1u3o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNNd1u3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756454007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hd/Q4wK5Af44IVTmRDhb0IMpmen0zove7usKL1pLP5w=;
	b=DNNd1u3oyk5Ne6cdy29gEoalm+4Y41ussRNFuyOwh7YM/iEgUcMAL6v5VNWit4SWxkW9rm
	Td2n599xdq/s5kobaRLX26XzMhtlPvq44UAf/PDGLjK57j2bSlgoUA0QxdnEEvssbUfRcM
	/REwfvzXRuDHTcjMNMSmhgTSIMLsO64=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-9l6oIqb_Nie875IJ3kT_fQ-1; Fri, 29 Aug 2025 03:53:25 -0400
X-MC-Unique: 9l6oIqb_Nie875IJ3kT_fQ-1
X-Mimecast-MFC-AGG-ID: 9l6oIqb_Nie875IJ3kT_fQ_1756454002
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e87069063aso633684085a.3
        for <linux-s390@vger.kernel.org>; Fri, 29 Aug 2025 00:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454001; x=1757058801;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hd/Q4wK5Af44IVTmRDhb0IMpmen0zove7usKL1pLP5w=;
        b=vdUWhZNaP9dUA4l01dtCRP2Om+zKOtK/06FOvR+igV4T15FtZ2qBBKqpGq7IqlHDAr
         p3hMQQkxgTJLncwFLPCaOae44PnFRqRJ/Ry1cODF8RTY5PoDnuLdCOn3y81HaT266JAB
         HcJnNy3u0OySIpSCujrBUKRoEr9tB80QUAePST4D1uhODadWf2Og7Fqbra4hYpHWgLFD
         ceVZ3WlNs7JnW6p7E4V5l2L8qq4XXKbxtnlMiKI3Do3JtnvRU1pO0ev9VRU4crKNXX5W
         cvGT9PKhpmDXtNRRyRLdLIrf3ABUNRxfrdw5VVYlCn+zCc00ikdmlthdGFOfBI3K9akf
         Bx2A==
X-Forwarded-Encrypted: i=1; AJvYcCWjpme1YOvOvFpaw+oYK6XRHlPxBpvqtLknQ1UaXi8gZs4i6hu+grxJqkDtdZnHhqweUhiehtJOPd2Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6vdmneb/k90vP2/DA7QrTeCuhRwnvLUPfAfp/Brzmvc0AALi3
	mq99HdJMAS+TKbygJay9F1Tr66oantx/HnNk0SRbyQ/ndVodYFxynEGw5nPzXZFJMsrph1i/DKC
	AaQj/n1wM8qbh3ecmCL041Xe5+qw1bkGf6BCMRNZy7HpuY57OQD4hEfS0KqM+B8pECXhGCT7Oom
	tmwNCs4CxctQ5lSOqVpyKco9HBE81hyEhj1gN3KSmWANeLniM=
X-Gm-Gg: ASbGncvJnZI4BlYnNoDxInVBju/3IpSRMuARmiAoKTgk0UXMir6HB7IVHDHzzUWNABP
	2NeweON8GYU3EnhaqS+Vlh+zou2H/FC7SBxLAIS3EZcq4x8/VivG8sW2zwA+2HozJ3nxqZ0GNit
	zq7th8BXlRA662UxLT/kWPdMG73MgSmOTc0QgMP+TVWHe0ssHdHMlKYqNqQPRHpc2ZrH0v7LBWF
	1aiXLZG621RNGKLUsOm17lGj3ieG9lufucK+g2Wp1X5LKODWTu+Ddqp6K0D1Y8/+Erfe4PCV0UY
	2yJdguQIduq/9GTj1tl1etdkGJVVrn/Yse7n+qlCLl8oAVPNc5YLZtLYsKO0Bmj0YVyVC7jx6IV
	wkCITvYUBfDa/BRtBsABQr6OY
X-Received: by 2002:a05:620a:3184:b0:7fd:2801:11c3 with SMTP id af79cd13be357-7fd280114e2mr79780785a.17.1756454001465;
        Fri, 29 Aug 2025 00:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9OYt/OUzYXYXQDHJZwPmeAhxWwWDVQls1oZvlM8N0wCLdQg6ik5gqoc+qY2nFzfns/uXsYQ==
X-Received: by 2002:a05:620a:3184:b0:7fd:2801:11c3 with SMTP id af79cd13be357-7fd280114e2mr79774785a.17.1756454000877;
        Fri, 29 Aug 2025 00:53:20 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc066657fasm134986185a.0.2025.08.29.00.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:53:19 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Shrikanth Hegde
 <sshegde@linux.ibm.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 thomas.weissschuh@linutronix.de, Li Chen <chenl311@chinatelecom.cn>, Bibo
 Mao <maobibo@loongson.cn>, Mete Durlu <meted@linux.ibm.com>, Tobias
 Huschle <huschle@linux.ibm.com>, Easwar Hariharan
 <easwar.hariharan@linux.microsoft.com>, Guo Weikang
 <guoweikang.kernel@gmail.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Brian Gerst <brgerst@gmail.com>, Patryk
 Wlazlyn <patryk.wlazlyn@linux.intel.com>, Swapnil Sapkal
 <swapnil.sapkal@amd.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Andrea Righi <arighi@nvidia.com>, Yicong
 Yang <yangyicong@hisilicon.com>, Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>, Tim Chen
 <tim.c.chen@linux.intel.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH v7 0/8] sched/fair: Get rid of sched_domains_curr_level
 hack for tl->cpumask()
In-Reply-To: <20250826101328.GV4067720@noisy.programming.kicks-ass.net>
References: <20250826041319.1284-1-kprateek.nayak@amd.com>
 <b64c820d-084a-40d9-bb4e-82986b9e6482@linux.ibm.com>
 <20250826101328.GV4067720@noisy.programming.kicks-ass.net>
Date: Fri, 29 Aug 2025 09:53:12 +0200
Message-ID: <xhsmh7bymlg2f.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 26/08/25 12:13, Peter Zijlstra wrote:
> Subject: sched/fair: Get rid of sched_domains_curr_level hack for tl->cpumask()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon, 25 Aug 2025 12:02:44 +0000
>
> Leon [1] and Vinicius [2] noted a topology_span_sane() warning during
> their testing starting from v6.16-rc1. Debug that followed pointed to
> the tl->mask() for the NODE domain being incorrectly resolved to that of
> the highest NUMA domain.
>
> tl->mask() for NODE is set to the sd_numa_mask() which depends on the
> global "sched_domains_curr_level" hack. "sched_domains_curr_level" is
> set to the "tl->numa_level" during tl traversal in build_sched_domains()
> calling sd_init() but was not reset before topology_span_sane().
>
> Since "tl->numa_level" still reflected the old value from
> build_sched_domains(), topology_span_sane() for the NODE domain trips
> when the span of the last NUMA domain overlaps.
>
> Instead of replicating the "sched_domains_curr_level" hack, get rid of
> it entirely and instead, pass the entire "sched_domain_topology_level"
> object to tl->cpumask() function to prevent such mishap in the future.
>
> sd_numa_mask() now directly references "tl->numa_level" instead of
> relying on the global "sched_domains_curr_level" hack to index into
> sched_domains_numa_masks[].
>

Eh, of course I see this *after* looking at the v6 patch.

I tested this again for good measure, but given I only test this under
x86 and the changes with v6 are in s390/ppc, I didn't expect to see much
change :-)

Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>

