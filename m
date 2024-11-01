Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3891182BD;
	Fri,  1 Nov 2024 02:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730426814; cv=none; b=A1S1DPebBCvKzfJR51otQk6GWr9qCqS4QJ9X9/ycAIuEmcLImKLjp3PwGH5JkdKEpd2dLB6SldM9v91WnER+pZmgG+OG6Zm5A2oMGsZLozRMcoCvh+em2W/2eH78JqLCDJOjpwvbMrQmtWe0EWOUx0Mwd7pPKz2Hym0oEyIFv9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730426814; c=relaxed/simple;
	bh=v1VJyxzhMU27MO5PGoO4nt7uc4hovgDFLcmA5uYYvHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYWeZ3yY6SGI2AMGz1xaulQAOBf7w0yMqm4EfdW42B6PjlXZqShWtHJnky/nQfsRG3374he8Uved5mz4Wz0IZbrjEjaxEPhPKcnSl+qiS5T2rYfo1QlRF+R/bMyzKtOcIhggYEJZOUDJSMn5pm/FDzrmNHf2M2SguFARKvzjvVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGxOL/2s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGxOL/2s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE429C4CEC3;
	Fri,  1 Nov 2024 02:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730426813;
	bh=v1VJyxzhMU27MO5PGoO4nt7uc4hovgDFLcmA5uYYvHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cGxOL/2sHfACj8zui4/gZWQIfeMlYPIHYxW85znfcJMTOy1zHtdkiGResRvf/7Rqy
	 ZP2u7FSmu4ctQo/5XfHmVD+zgLkiecD/tOGo8zoW0KOO6kmpBeNcKHC4kSV8DI+2yP
	 Oo+nEgU8b2O8w6v+s9TFasvisfBRQR/Y5d6eoGWryGK8zJNs/XGWprsZB2U7UeE0RP
	 gHPMxTEEnRqoVOe5pIuTJzOR+BQQnrywQhYJrNSQIMRBdRZbiHfpFqBcxidERJzMYX
	 btGxfPWBkBa2KCkoqncprnVaXH6uXb6L53dbED6XfQK96C7K9bEYXo/wZD7zovkmb7
	 B3FVwyeVuLZXg==
Date: Thu, 31 Oct 2024 19:06:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: liqiang <liqiang64@huawei.com>
Cc: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>,
 <alibuda@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
 <guwen@linux.alibaba.com>, <linux-s390@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <luanjianhai@huawei.com>, <zhangxuzhou4@huawei.com>,
 <dengguangxing@huawei.com>, <gaochao24@huawei.com>
Subject: Re: [PATCH] net/smc: Optimize the search method of reused buf_desc
Message-ID: <20241031190652.5f775796@kernel.org>
In-Reply-To: <20241029065415.1070-1-liqiang64@huawei.com>
References: <20241029065415.1070-1-liqiang64@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 14:54:15 +0800 liqiang wrote:
> We create a lock-less link list for the currently 
> idle reusable smc_buf_desc.
> 
> When the 'used' filed mark to 0, it is added to 
> the lock-less linked list. 
> 
> When a new connection is established, a suitable 
> element is obtained directly, which eliminates the 
> need for traversal and search, and does not require 
> locking resource.
> 
> A lock-free linked list is a linked list that uses 
> atomic operations to optimize the producer-consumer model.

Not sure what the story here is but the patch does not apply to net-next
-- 
pw-bot: cr
