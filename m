Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5518B1B14FE;
	Wed, 14 Aug 2024 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647048; cv=none; b=sjqDvMbdrC6D5VEZaW/d9fHOgUX7t3I6Q++R299+AdIP5f4/zeN5la24UKCJLsLiwmpxNcdmap2xtf1Cg0tGE+yzzykrVkcF05uAqp23CLFGoIcV6PNP+tHTAcjtMt8PI9YXezmWsqQTg79cUKFb51WeQqA/MSLhLFhiaHJgGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647048; c=relaxed/simple;
	bh=bbKpY7ZsDWl0kVfLOUJ/7WFjTHp6GufBCWxqT1vhqlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVDNJp8N1c1v9SPz/ZCa2biycPp5QtSd68wx0E+qLhywvK9lgHkh767ymynw+vAU2KeBbG4hYQhionHHdMcWh02mqyq5gqsHQWyM47ddWMOj18R7K3wx8rA7ii4y17J+CtssNaao1lsAk74h/q3iTgaaXO0V1plZDV7l5AZh4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWbk3SnX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWbk3SnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FB8C4AF09;
	Wed, 14 Aug 2024 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723647047;
	bh=bbKpY7ZsDWl0kVfLOUJ/7WFjTHp6GufBCWxqT1vhqlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RWbk3SnXUX12g46bHa8erDEsRpFLPgz1qCpLjrvuOuV5Ufi6ULXmKNEsde6QTw8Z+
	 eNeUkmt+p1VFEJbcWVrxouHhNYLrDpIECzA4EOcRhSUDFjGDHEECsEWoOpwE6btZgr
	 S6Bzcfjkdm7wxRVwIKtPcMJFvLNRx2cDnZFBNYsB/e/953ZCFsthBUeBoRSVkEKGMF
	 ETeoj8xDqXokpop3zq184D185bza/5rYYpgNSxzldmFkGl+yw3CNU+zASVBrp691uy
	 OjAPffiMOtipzsr5WZESyWlAX8d08c2ZOomrggqUEDVcDHPcmkHpevoJcWTl7p9rVw
	 AFSlbv0z9F8zA==
Date: Wed, 14 Aug 2024 07:50:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net/smc: introduce statistics for
 allocated ringbufs of link group
Message-ID: <20240814075046.11635ea6@kernel.org>
In-Reply-To: <b680756a-920d-419f-92ec-4be06aa3d8f5@linux.alibaba.com>
References: <20240807075939.57882-1-guwen@linux.alibaba.com>
	<20240807075939.57882-2-guwen@linux.alibaba.com>
	<20240812174144.1a6c2c7a@kernel.org>
	<b3e8c9b9-f708-4906-b010-b76d38db1fb1@linux.alibaba.com>
	<20240813074042.14e20842@kernel.org>
	<b680756a-920d-419f-92ec-4be06aa3d8f5@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 11:10:33 +0800 Wen Gu wrote:
> >> Hi, Jakub. Thank you for reminder.
> >>
> >> I read the commit log and learned the advantages of this helper.
> >> But it seems that the support for corresponding user-space helpers
> >> hasn't kept up yet, e.g. can't find a helper like nla_get_uint in
> >> latest libnl.  
> > 
> > Add it, then.  
> 
> OK. So I guess we should use nla_put_uint for all 64bit cases from now on?

Yes, actually I'd go further and say all ints should use the variable
size types, unless we are guaranteed they will never be larger than 32b
(e.g. ifindex is used in many places in uAPI as 31b already, we can't
grow it), or the field is explicitly fixed size (e.g. protocol header
fields defined by standards).
