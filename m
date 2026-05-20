Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4125233B97A;
	Wed, 20 May 2026 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292307; cv=none; b=LhC09t2q/xbmMM5aRmE+WLVonsyDxTfGCVqxex0cSrhTlQyLzwEg6/9hzKdwZUa+ZYRcSEwqnUF5e06wKsqiEp3ql0AFtqH/mIPz94ZJQKzSKA+PipIAaMOZzhZ3TGZ9jcMU3aQWnoT+6lz2m+e6KwBXvRikrWAK2+27xyBx7yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292307; c=relaxed/simple;
	bh=kOLHBiAE8jzr/6A/jfKB80TncYB/sF5NVut1RV0l83s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcdFgDOeuJJiEqqQTQFgyxp5RutSfm/dBNtVLpk0WUQ61bD7ttxiyJn2DedTo6BW293AddnjaBcZ/kyKFAmUEDZlkCiiClFNzSqEqhmyT6AmZNI9QJe/LXY+ydLsmg6wwXWiykbBxn25z7fCW6LlkDAcBtfiTDoaO79eRIquFPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cyaqbLsB; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cyaqbLsB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nHpPl/F5wMWITSrzVhdG/rFO68ZENNnx6ANAJViJJd4=; b=cyaqbLsBd8TuWcXbuV/p5H62kB
	CPDi3rJN3wZOEF/fhu8hFy+E+oVys1eKQlanPYBPekgaq//TV2sSD7Jchzv2LgBbxXhcOOC0l0Ry8
	9SnhwSFGySALbCrBsjDCC5O2wjGvIOCbRSABlsk+Ib1fGGnL4KqoZorXYfy1GmNhI2cd3LOTuECCv
	lMwE1IdyRtXlXLQtC4JvBPki8Md0j2IcpmpYhZiq6N0e4CJwOuZ7UpBpPFJi8N8bfHdB1HPnxnRv8
	ZZrYqWVRQak1F6Q4qVwFsn3WfAXJpo7BNBy5OhFYXlXJvdw22uerI5O3BWMxUehl76ZANhRMzCIl6
	SgYkrggQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wPjCH-003DHq-0U;
	Wed, 20 May 2026 15:51:01 +0000
Date: Wed, 20 May 2026 08:50:54 -0700
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
Subject: Re: [PATCH net-next v2 3/7] atm: convert to getsockopt_iter
Message-ID: <ag3XTX5rXE4tNbsT@gmail.com>
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
 <20260515-getsock_four-v2-3-0d8eed952627@debian.org>
 <eada2df3-7e3f-46a5-b290-fe0e8975a1bb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eada2df3-7e3f-46a5-b290-fe0e8975a1bb@redhat.com>
X-Debian-User: leitao

Hello Paolo,

On Tue, May 19, 2026 at 04:04:12PM +0200, Paolo Abeni wrote:
> On 5/15/26 10:32 AM, Breno Leitao wrote:
> > @@ -797,13 +798,13 @@ int vcc_setsockopt(struct socket *sock, int level, int optname,
> >  }
> >  
> >  int vcc_getsockopt(struct socket *sock, int level, int optname,
> > -		   char __user *optval, int __user *optlen)
> > +		   sockopt_t *opt)
> >  {
> >  	struct atm_vcc *vcc;
> > +	int val;
> 
> I *think* you should use 'unsigned long' here to avoid user-visible
> changes due to put_user() replacement.

I initially used 'unsigned long' in v1, but that proved incorrect and was
flagged by sashiko:

https://lore.kernel.org/all/agXhTGVurhrJmBNu@gmail.com/

The issue is that we need a 4-byte operation here since both __SO_SIZE
and SO_SETCLP are 4 bytes. Using an 8-byte type causes copy_to_iter() to
truncate the copy to 4 bytes while returning 4, which could result in
copying the upper portion of the 8-byte value (potentially all zeros,
depending on endianness).

Thanks for the review,
--breno
