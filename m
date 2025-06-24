Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEEF299AAA;
	Tue, 24 Jun 2025 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769467; cv=none; b=dTgiVMj4SkcySbg2iRjmEe5xeCRYC2zyl8K+V+XXJ6ldq6+c49G24DaW7O7z3o4pI6LG6E81LfyujK+U0OhaIuLnZ6/33qDq5tie4Oh2g8b/BKuW+nAZyqPNL6ppKP6log7O0agN9Y81kGgpBfObVZxtkgFbl4xKPhksEiNQCOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769467; c=relaxed/simple;
	bh=zq3kuUNqKPmj8UgCERj7i2pYT9nNSZmSo/CiqWWDdZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/pPRYdfOJEmtgWzTESVaT5YPGr+Sx4/V5McfOO00QfhO/+Cp/piy1gnPRdOzM40J1st0620ZU33QyjZfquv5x0P452nTP3MtsCXntAnJZKM/xhCZMEwuEmagL7d+Q+66xxaqCO09yhtLpZ0/f6dez/6NRzujCNIPyZNG6OxmVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MtHBv3ac; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MtHBv3ac"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750769459; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=zq3kuUNqKPmj8UgCERj7i2pYT9nNSZmSo/CiqWWDdZg=;
	b=MtHBv3acqCMbj6KuUuLPO/oEMD8JWLUlxGpibVDg+RQV7RdHz5JZH3QMUYxs76dbeiiG4HY8w5xxhKzrMLaYJikDJ8MBrOVf15UIqz6btKnvRhIzDWSkvaDO0aBO+Lppio9my56BBLe8+S7pq+xSLsKJRZfx9hAidkWbBwNjuRo=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WehfwiW_1750769458 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Jun 2025 20:50:59 +0800
Date: Tue, 24 Jun 2025 20:50:58 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Jan Karcher <jaka@linux.ibm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>
Subject: Re: [PATCH net] MAINTAINERS: update smc section
Message-ID: <20250624125058.GD10186@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250623085053.10312-1-jaka@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623085053.10312-1-jaka@linux.ibm.com>

On 2025-06-23 10:50:53, Jan Karcher wrote:
>Due to changes of my responsibilities within IBM i
>can no longer act as maintainer for smc.
>
>As a result of the co-operation with Alibaba over
>the last years we decided to, once more, give them
>more responsibility for smc by appointing
>D. Wythe <alibuda@linux.alibaba.com> and
>Dust Li <dust.li@linux.alibaba.com>
>as maintainers as well.
>
>Within IBM Sidraya Jayagond <sidraya@linux.ibm.com>
>and Mahanta Jambigi <mjambigi@linux.ibm.com>
>are going to take over the maintainership for smc.
>
>Signed-off-by: Jan Karcher <jaka@linux.ibm.com>

Hi Jan,

Thank you for all your contributions to SMC over the past few years!

And thank you for your recognition, it’s truly an honor of mine to
be one of the co-maintainer of SMC.

We will continue working closely with IBM to further improve SMC.

Best regards,
Dust

