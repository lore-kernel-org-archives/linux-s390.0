Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809A31E84E;
	Tue, 23 Jun 2026 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227567; cv=none; b=YsKa2EytF+MtkHAmZG1/gNtXiN98LB2ksKsudHaXJpYHSpFfyUNUdUFK2m+g7L4/qXqWE5czi3ZSmOzwkmVffMfXGih5i8bV1/5EorgNaykWVWRd9eQTr68W94MlLQvQBc/dNbrtxJB2eSb+/66vnnaxEaZUBjYrFLJRYACgjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227567; c=relaxed/simple;
	bh=nPC4jdeJcRErLmYE+XtVF3VnxBQ2rVXb5nY0nlEKnRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du1Crdz8oZC8WdSElNh1c9ytlBsJCIbOLMPbyOvQ/CHz91t/mgwRZgMspOfwoeJV/30uXOwlpl8tgYK3Q3cUUKGzrOTkjPiI3iZA+2aU1zIrK7i5RaO4XcsnkdfVlaXhrZhh3WbP14byGHEHTSUW+qOxJXPOS5uBYZ26Er8VdMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=o+gcWmXA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="o+gcWmXA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GqkkKeTlLEue6st69aJaBvzWr7y8e4iXOI20z07pTsM=; b=o+gcWmXAdYjZqz94bMd6mlmTqZ
	KciTdDSSP879m3W5yR696vuTIAUwxoO2nQtkXPTLhEm0NA2K9AAedLmNu1oUbylD0petHRIybNzul
	QmDr8f/4ucgdQStKPwwtVoepaxIQxu2SqU854Ce74+5xUVYnsdaVxvDADQet/Dw1j1e5O+wUqeRR0
	e8MvpreKu5utObjQl0hns16vzEq0JCAC16gSjZLnpEWCx9pe+6/gB+W+1GBOMRFJ/1XFu+cwTpIUF
	pFKEWzfJJ8CiCfmOfkBcu2HoCRxVFAse77fUvwkmM6T0gxobmI3f9wdN7vVNBXSsbEil+LGTuyfHM
	OGu9L1+g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wc2ng-001jhy-3D;
	Tue, 23 Jun 2026 15:12:33 +0000
Date: Tue, 23 Jun 2026 08:12:27 -0700
From: Breno Leitao <leitao@debian.org>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com, 
	dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com, 
	wintera@linux.ibm.com, pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com, 
	guwen@linux.alibaba.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next v2] Documentation: net/smc: correct old value of
 smcr_max_recv_wr
Message-ID: <ajqh_3YDwz9q5Aiz@gmail.com>
References: <20260424052336.3262350-1-mjambigi@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424052336.3262350-1-mjambigi@linux.ibm.com>
X-Debian-User: leitao

On Fri, Apr 24, 2026 at 07:23:36AM +0200, Mahanta Jambigi wrote:
> The smc-sysctl.rst documentation incorrectly stated that the previous
> hardcoded maximum number of WR buffers on the receive path (smcr_max_recv_wr)
> was 16. The correct historical value used before the introduction of the sysctl
> control was 48. Update the documentation to reflect the accurate historical
> value. Also fix a couple of minor typos.
> 
> Fixes: aef3cdb47bbb net/smc: make wr buffer count configurable

This Fixes tag is broken. You probably want:

	Fixes: aef3cdb47bbb ("net/smc: make wr buffer count configurable")

Other than that, it looks good, the corrected value checks out.
