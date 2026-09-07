Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2857478;
	Mon,  7 Sep 2026 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788745690; cv=none; b=kY9Mlkp1tWLA7BXE0X3eCyc5TTyDrnmDnhGQ5mhs9lmno8YQHfLKe61GTeiuM8QMKpX5ED4vWz/wN8JgsWLEswMtWZDuiUKGlyyfJxe5Rpvkqv4+HEBeMfVduGmthCZw0kw/nuwmkRSDo2Tsim1A3Z+tG5Qy4sgPCh1BRIt7LhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788745690; c=relaxed/simple;
	bh=vFytQWE+rHf1XGkyGbMkc8jhW5fkRcdbQbyaN4bBrAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0f5NuE7/aoGtNMoqJsGLl8vzhkmjFwNSQaMP12aE8t4dodsL1vhoNnfotgu1W5p51a//M4CcA2dXD5uSDjdqvAGn7b+QNVmKqyOCwETeqOEUa5PKoh7JDOz7792pStHjucLtJb0FJ9+HHWsRmO9Y5qQXS+1Bu6A4jfW3zLxlus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jTqYfjtQ; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jTqYfjtQ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788745677; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=jvjzUwP+xcVDuql+kCr25t00Fk3uorZPRuXdtwHQxwg=;
	b=jTqYfjtQNidgpi4DDfe9KecasLzkf3DCS/x2VTmqAVmcMHph58Clvc3azUC6/1RcHXd8NflAiJcG8cosXdDQFPeC6BvRfqUiq9cM+3vQCDO3s3u+LRjaSdJ8TsRHGh4tXhxUmNQVNU3NpfO0K0ELwrlCSER2rymJZduSicmKTN8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0XAO40Tn_1788745676;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0XAO40Tn_1788745676 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 07 Sep 2026 09:47:57 +0800
Date: Mon, 7 Sep 2026 09:47:56 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Denis Arefev <arefev@swemel.ru>, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karsten Graul <kgraul@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Ursula Braun <ubraun@linux.ibm.com>, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [PATCH 5.10] net/smc: fix potential panic dues to unprotected
 smc_llc_srv_add_link()
Message-ID: <ap4XzBSJrJMoPJiZ@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260901090545.10419-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901090545.10419-1-arefev@swemel.ru>

On 2026-09-01 12:05:43, Denis Arefev wrote:
>From: "D. Wythe" <alibuda@linux.alibaba.com>
>
>commit e40b801b3603a8f90b46acbacdea3505c27f01c0 upstream.
>
>There is a certain chance to trigger the following panic:
>
>PID: 5900   TASK: ffff88c1c8af4100  CPU: 1   COMMAND: "kworker/1:48"
> #0 [ffff9456c1cc79a0] machine_kexec at ffffffff870665b7
> #1 [ffff9456c1cc79f0] __crash_kexec at ffffffff871b4c7a
> #2 [ffff9456c1cc7ab0] crash_kexec at ffffffff871b5b60
> #3 [ffff9456c1cc7ac0] oops_end at ffffffff87026ce7
> #4 [ffff9456c1cc7ae0] page_fault_oops at ffffffff87075715
> #5 [ffff9456c1cc7b58] exc_page_fault at ffffffff87ad0654
> #6 [ffff9456c1cc7b80] asm_exc_page_fault at ffffffff87c00b62
>    [exception RIP: ib_alloc_mr+19]
>    RIP: ffffffffc0c9cce3  RSP: ffff9456c1cc7c38  RFLAGS: 00010202
>    RAX: 0000000000000000  RBX: 0000000000000002  RCX: 0000000000000004
>    RDX: 0000000000000010  RSI: 0000000000000000  RDI: 0000000000000000
>    RBP: ffff88c1ea281d00   R8: 000000020a34ffff   R9: ffff88c1350bbb20
>    R10: 0000000000000000  R11: 0000000000000001  R12: 0000000000000000
>    R13: 0000000000000010  R14: ffff88c1ab040a50  R15: ffff88c1ea281d00
>    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> #7 [ffff9456c1cc7c60] smc_ib_get_memory_region at ffffffffc0aff6df [smc]
> #8 [ffff9456c1cc7c88] smcr_buf_map_link at ffffffffc0b0278c [smc]
> #9 [ffff9456c1cc7ce0] __smc_buf_create at ffffffffc0b03586 [smc]
>
>The reason here is that when the server tries to create a second link,
>smc_llc_srv_add_link() has no protection and may add a new link to
>link group. This breaks the security environment protected by
>llc_conf_mutex.
>
>Fixes: 2d2209f20189 ("net/smc: first part of add link processing as SMC server")
>Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
>Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
>Signed-off-by: David S. Miller <davem@davemloft.net>
>[Denis Arefev: adapted for 5.10: smc_llc_srv_add_link() has no 
>req_qentry argument here, as SMC-Rv2 REQ_ADD_LINK support is
>not present in 5.10]
>Signed-off-by: Denis Arefev <arefev@swemel.ru>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust

