Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE191D556;
	Tue, 13 Aug 2024 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560044; cv=none; b=K8p6PaM/Fx9OECmZXMNK9fhwoptofONkIRffmfseRqRPvHbVl0JdyK3QSVFtz2nbk5lo4oFAUoZ6YJtjrC0F1tNbGSJTNviagNGAj6N6AbbELlBrT6iOMeWZ4cf4eomRXyTDOECVzvVzRYk6pr31swQxFtHTJgUT30QvdtY3kz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560044; c=relaxed/simple;
	bh=3mtwcw8cIpdiaFg8tJrwA2QQtyR1zaK7gcobQGihP5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiW7KthFjckwnJHAjUE4/UzOXY0FzwLL2leqeOISVChOsQuwM4Cd22GqryoKGBJHNtZrL0Edae25rU2+4jZB95Ppti41oG1uc2A5YhIbMALatEY3CGGqnRXm0H5ZUuUKHeUQprw9BoDw7QVolSXAlJMTTMdiT/+6qdZNApz60LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SetsQxGE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SetsQxGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BA1C4AF09;
	Tue, 13 Aug 2024 14:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723560044;
	bh=3mtwcw8cIpdiaFg8tJrwA2QQtyR1zaK7gcobQGihP5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SetsQxGELs8awFF3bRGJPR/k66veI0jQ71TtxPTFsmhgX/1WRLpGjVYl/Jsl47Qxe
	 539SrsciKNze5cIb02gWia30GpltCsycfaMKtEgkhMV4VSQSpXN/tXowb2TaZZfkC+
	 2oLitHj4foQicehBe9/LQIWwZ5YKZfsHlt9uQ912V5R3SDJFqThkYgsNH/1QRxgMqN
	 Of+7xGhDxXNGnzLDeagfds3fgsnne33yz7lYoq5DaVTeNjm231Bjd+y76uLfQp3YN5
	 98Dl3A6ZRsxIecmTgTKEYGpo79SwXAhF85pILSZiepdv1grBWTdl2CNsHm4JwFZ5Nq
	 G0wtJKs6RdEEQ==
Date: Tue, 13 Aug 2024 07:40:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net/smc: introduce statistics for
 allocated ringbufs of link group
Message-ID: <20240813074042.14e20842@kernel.org>
In-Reply-To: <b3e8c9b9-f708-4906-b010-b76d38db1fb1@linux.alibaba.com>
References: <20240807075939.57882-1-guwen@linux.alibaba.com>
	<20240807075939.57882-2-guwen@linux.alibaba.com>
	<20240812174144.1a6c2c7a@kernel.org>
	<b3e8c9b9-f708-4906-b010-b76d38db1fb1@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 17:55:17 +0800 Wen Gu wrote:
> On 2024/8/13 08:41, Jakub Kicinski wrote:
> > On Wed,  7 Aug 2024 15:59:38 +0800 Wen Gu wrote:  
> >> +	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_R_SNDBUF_ALLOC,
> >> +			      lgr->alloc_sndbufs, SMC_NLA_LGR_R_PAD))  
> > 
> > nla_put_uint()  
> 
> Hi, Jakub. Thank you for reminder.
> 
> I read the commit log and learned the advantages of this helper.
> But it seems that the support for corresponding user-space helpers
> hasn't kept up yet, e.g. can't find a helper like nla_get_uint in
> latest libnl.

Add it, then.
