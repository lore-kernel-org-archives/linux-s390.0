Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECD031E83B;
	Wed, 20 May 2026 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292308; cv=none; b=DvxjnFY75NR1ktzvXaUi9aJxBhkdKwuwhzP19iYC6smnu2ktXEBmcgF3j9ph15bgAUC2Eht0i9pIFs7JkCZlLMrfWvtMd8SK/bX7FWfAdokB9ze/IHnWXT2YdQYIxWlzMA7toG3p2+0uiemsg8ClXeCdy96fb3ffxskk5vcyeu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292308; c=relaxed/simple;
	bh=NAhBWWg0ZB6CWA3GG19rCME9ogowW2XuxCUrHrVRqWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ap7UoCdBTzKycGODD8iDeXQzYsne+3WW2DKTiZd5RJOPiouGPMruWkhsX7TZL+IgS1LKvZjQar4wI1uei15FE3dYnwvTd3SMcFgKPxFzFol9oyTDTqZsobEF7GtC6lsVUkt0/hT7MQULiogXNPrDWIY8fYoOrHsVK6Ok8cT+PYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DnSQVey9; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DnSQVey9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zM2fDYjr7qWmpfBnwppxYNYYbD5OjkaB0pbTrkWJHgs=; b=DnSQVey97xe5fnMBLjn9QZx0HA
	AF0XEKmr0IKIUtwOcQj4ehdpVygEk1fHUsdfsJKObiJJRG0jvsnBHV1kzrBOmWJMw42NGZjQSwtFj
	/3jOVO2r8gD9NX6lNcxup6eJgTL6JWZSIwoDUeT2t1psaXtFYrpDJYPAhPk+sx0+HC6Q3p4Vec7Yp
	rtUd/Whl6Q+Zppv5YuJlFgUVu92ny8tS7TJmfZXW1lPfGePNlLwHq9eFsBQpTpX+q05rYspQu2+sX
	k5stw31rkkYrN6KAI77aVfp2VL9MtXnnCRzpXqOk6m5O0NE/69FXSaDdSR9UlyvMVnYmAgR+n3gO8
	EazlwY1A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wPjCi-003DI3-0W;
	Wed, 20 May 2026 15:51:28 +0000
Date: Wed, 20 May 2026 08:51:21 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Chas Williams <3chas3@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, 
	James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, David Heidelberg <david+nfc@ixit.cz>, 
	Samuel Ortiz <sameo@linux.intel.com>, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-s390@vger.kernel.org, linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2 7/7] tipc: convert to getsockopt_iter
Message-ID: <ag3Ya7YK3iTi3ERI@gmail.com>
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
 <20260515-getsock_four-v2-7-0d8eed952627@debian.org>
 <c05304bd-1c7a-486a-9929-e6947de07adb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c05304bd-1c7a-486a-9929-e6947de07adb@redhat.com>
X-Debian-User: leitao

On Tue, May 19, 2026 at 04:08:39PM +0200, Paolo Abeni wrote:
> On 5/15/26 10:32 AM, Breno Leitao wrote:
> > @@ -3260,7 +3260,6 @@ static int tipc_getsockopt(struct socket *sock, int lvl, int opt,
> >  		break;
> >  	case TIPC_CONN_TIMEOUT:
> >  		value = tsk->conn_timeout;
> > -		/* no need to set "res", since already 0 at this point */
> 
> Since you have to repost, there is another obsoleted comment referring
> to "res" later on:
> 
> 		return res;	/* "get" failed */
> 
> please strip it, too.

ack!

thanks for the review,
--breno
