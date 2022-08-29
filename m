Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BD2ECAAD5
	for <linux-s390@archiver.kernel.org>; Mon, 29 Aug 2022 12:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiH2MVz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiH2MVg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 Aug 2022 08:21:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE1E77EB3;
        Mon, 29 Aug 2022 05:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qcOOGcUR+Q47tfc7ZQUsunuQSihKNR/YxuJlx8zxYMI=; b=eHd2QHsK8dfIVJ5r+QNtVVQPkH
        oqFlf9a9fWdDPCXSn7g7aVnwrNDPzUAnqC9EZquRyFPItExfd/d+RYfnOUS3WgkurtCKVAKDhZRI9
        59Ts7WhPLbpu5gK/OkXTr3DTnsIPiwBBBK/FPUgXfRwbe26LSUWrFC6TFXi+CS0uxa0L+J2IzPFBy
        FWNSoqp6ziWeIvIOihGWJKh5sgbwSgMcEvshuPFkLI25/uwcePeGFopw1jf9SYLuSMTGFZ+KgEvOH
        LFFdjw1I7Bz/kSoeQTWtWV6/O1IKnGJB77atySc0cJc9yd3jlB0xeraP+q48fn5mB4wiHj3kGsgdY
        TMhDfvBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSdVM-0034ba-RJ; Mon, 29 Aug 2022 12:04:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E8BCA3002FE;
        Mon, 29 Aug 2022 14:04:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE6E020715121; Mon, 29 Aug 2022 14:04:33 +0200 (CEST)
Date:   Mon, 29 Aug 2022 14:04:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        will@kernel.org, robh@kernel.org, mingo@redhat.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH] perf: Rewrite core context handling
Message-ID: <YwyrUYS30gVbxc2D@hirez.programming.kicks-ass.net>
References: <20220829113347.295-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829113347.295-1-ravi.bangoria@amd.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Aug 29, 2022 at 05:03:47PM +0530, Ravi Bangoria wrote:
> @@ -12598,6 +12590,7 @@ EXPORT_SYMBOL_GPL(perf_event_create_kernel_counter);
>  
>  void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
>  {
> +#if 0 // XXX buggered - cpu hotplug, who cares
>  	struct perf_event_context *src_ctx;
>  	struct perf_event_context *dst_ctx;
>  	struct perf_event *event, *tmp;
> @@ -12658,6 +12651,7 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
>  	}
>  	mutex_unlock(&dst_ctx->mutex);
>  	mutex_unlock(&src_ctx->mutex);
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(perf_pmu_migrate_context);
>  

Note to self; fix this :-) I'll see if I have time for that later today.
