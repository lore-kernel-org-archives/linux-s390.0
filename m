Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6D3F0A8F;
	Fri, 15 May 2026 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778832957; cv=none; b=q4+yHNkK+OjhJwQmYdWH3Bgl7d3g7NVA3tqWx45Sk8TgcANW2kFmL2lBG6i9GHiVkQz/oHNg6FiIin5N2168GNVyonp8J48MqZJbNDyN1rpJr4W3JV2pk/n99Fszvmbkfpn5Oi+P1PigL+J+Gr/wGy0O++fY2DDfP7rPLa05MCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778832957; c=relaxed/simple;
	bh=pn5Bt2djtKvNo/mokG6x5amT/ycktCiUYk//0IkiJRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDrQlYg0OhvMNRG7FKVHivAC0txC2p/mIO+nG8yuAt8HBO2gsGQwrqq9HhTp7syjeCsTvXJHBLZLl7/bF297Y24jUtPER5lDLidzzwBZVYOcY4g6uXI/IRMKU89eg3paoluo++scGhnj/zXV9itge40wZqGqcl9+NZu8BHo706A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=BJmPYVsG; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="BJmPYVsG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2FFd0YZvzjAtbEKn0Cg4H/lM9Izey3C5itF2pPcZA0o=; b=BJmPYVsGyFPcHZdCHSjEnv07g6
	KHkjvufSohFkORf9CcHQLxbCX+AMKVzNk2HXmUVrsJ8Fty6awd3HtnAJSbHeXwPiwn7/Wr8B9qeCC
	qXM3r/ExrO6htkpKS7L3Y0p2Uww3eCJYAUoWZ0JoMG8/Xxeme40G/8nd+ZKpqBjcLe3SukKznSOjT
	n1Mm7RiWKD9MADhiodLES8RZRUv60zqH/OUHkgnpJ9TatinfdjVGGSpqQEM5Lq7QFM/L3KlFQO4WT
	p7OYtysU9AtI/Tp0x/injUUaWLbkg/f374WNtLrCnrcuqEOBtjf8aFPMYSF52kiRhJ0zNHTECyj/d
	HXgciK5A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNnhW-004aYs-2j;
	Fri, 15 May 2026 08:15:19 +0000
Date: Fri, 15 May 2026 01:15:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Chas Williams <3chas3@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
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
Subject: Re: [PATCH net-next 4/6] l2tp: ppp: convert to getsockopt_iter
Message-ID: <agbVsd9bzIhylAwH@gmail.com>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
 <20260513-getsock_four-v1-4-fe7f0e756fac@debian.org>
 <agSZeMEvxE0xyNB8@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agSZeMEvxE0xyNB8@devvm7509.cco0.facebook.com>
X-Debian-User: leitao

On Wed, May 13, 2026 at 08:32:39AM -0700, Stanislav Fomichev wrote:
> > @@ -1358,12 +1357,11 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
> >  			goto end_put_sess;
> >  	}
> >  
> > -	err = -EFAULT;
> > -	if (put_user(len, optlen))
> > -		goto end_put_sess;
> > -
> > -	if (copy_to_user((void __user *)optval, &val, len))
> > +	opt->optlen = len;
> > +	if (copy_to_iter(&val, len, &opt->iter_out) != len) {
> > +		err = -EFAULT;
> >  		goto end_put_sess;
> > +	}
> >  
> >  	err = 0;
> 
> nit: if you're moving `err = -EFAULT`, you might as well remove this
> `err = 0` ?

Good point, if we got here, err is already = 0, and this line becomes
useless.

Also, we probably don't need the "goto end_put_sess;" above, given the
next line is the "end_put_sess" label.

Thanks for the review, I will update.
--breno
