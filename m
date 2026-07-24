Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568541E6A3;
	Fri, 24 Jul 2026 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889831; cv=none; b=ByIX1wy1WFsRWf++4GNj3r5CjO1R5UlFqmVhnb7fEfMnbfSiXm/4mBNaQfOhd/1FYC6Fvukm+i0a8Rzjh0z5Pbjtov67L38/gcs9HlCuJrW0pCRE2OSdJIxd/qHbCTsDcSZ2lRqKZQUQBB+Wy7hjXXZ4xu/hMIJfbc8OheEH3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889831; c=relaxed/simple;
	bh=pRAMOkfszNVTPYoqs8gaqWJFMeqGwaTHbQXHU5PQewE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTsoCJAkzfQ1++I0Y7zIio3+vmV6P2rf92sGsf3DTnyVAgdSY+pntKyzB/133G0zneye1MJgqqWCX3ZvFk9fBe8jQ92KZRUuyqspnNUl/o/XhhroJKkfQWeEViu06MRDG+5VmfAyqxwOlgFNxg5rcBiBNeuLhDBFfkvslaRolHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VOemYsNu; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VOemYsNu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784889823; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=/tb1yUDXPW0r+fPbzxbj/o7VDUznNCjDbV8o01+8u40=;
	b=VOemYsNuK17l+0R8Oq4zgjHIbkPjhmcLNbDk9tQ2gAYBpAPm2V/wgHc23gGKR6K7nRlng4ENZppdnwulKP0ctV+2MNNDMBTOFkJ4G9HoXxKyKc7CsViGvQ45zQHXjjpCotgnR62SyqI2CJKynDNkDemGE5MwQWAKI/+6JL6vMdw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X7itryC_1784889821;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X7itryC_1784889821 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Jul 2026 18:43:42 +0800
Date: Fri, 24 Jul 2026 18:43:41 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>, aswin@linux.ibm.com,
	Alexandra Winter <wintera@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>
Subject: Re: [PATCH net-next v3] MAINTAINERS: Update SHARED MEMORY
 COMMUNICATIONS (SMC) maintainer entries
Message-ID: <amNB3dYaJhpHJG96@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260724053752.3084-1-wenjia@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724053752.3084-1-wenjia@linux.ibm.com>

On 2026-07-24 07:37:52, Wenjia Zhang wrote:
>Due to a change in responsibilities, I can no longer serve as an SMC
>maintainer and need to be removed from the MAINTAINERS list.
>
>To reflect these organizational changes, promote Mahanta Jambigi
><mjambigi@linux.ibm.com> from reviewer to maintainer.
>
>Acked-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
>Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>

Hi Wenjia,

Thanks for all the valuable work you've done for SMC! It's been a
pleasure working with you in the community, and I wish you all the best
in the future.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust


>---
> MAINTAINERS | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index ff93f3954fd1..031db6fa5522 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -24632,8 +24632,7 @@ SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
> M:	D. Wythe <alibuda@linux.alibaba.com>
> M:	Dust Li <dust.li@linux.alibaba.com>
> M:	Sidraya Jayagond <sidraya@linux.ibm.com>
>-M:	Wenjia Zhang <wenjia@linux.ibm.com>
>-R:	Mahanta Jambigi <mjambigi@linux.ibm.com>
>+M:	Mahanta Jambigi <mjambigi@linux.ibm.com>
> R:	Tony Lu <tonylu@linux.alibaba.com>
> R:	Wen Gu <guwen@linux.alibaba.com>
> L:	linux-rdma@vger.kernel.org
>-- 
>2.50.1 (Apple Git-155)
