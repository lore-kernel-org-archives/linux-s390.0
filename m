Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526F130C61B;
	Wed, 20 May 2026 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293034; cv=none; b=FN3w8Oe4mCVvGeTGKY30dpRCoIT+QjEjiFmMQcwCNiVWzkV3y4pdfqfqNYtSPIzFZxUbbd3R5KkfVxJsvS4a1OSJAuKBa5hJRSyl2GayiWjeJ0kTwcsOXMDQ16OhNTLalyZjD83HfH0QqmEsEmf3fN7xwB3rWtw2J6Amv9qva0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293034; c=relaxed/simple;
	bh=iREi0TgSWrf/+NC49XE3cMrSvYPy6cS+mt9MKwoijGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk9CKwWE8PoPd6U1c+aZd992AB5EP4qEQVWfIZZsaQvxr6f0CU+Q6FtMKZGsXH79MDgfe+dP+BfilBPdBIRAtkiqkzwpA6JJfCoTf7x+FQ4ce7Oro38oaldeBoJtfHVlKy2EslmPPrXQylFWJSMTkoeJVAPPyKkSBKY4b93ITcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=i6xcibCo; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="i6xcibCo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=S9ey94ABSE5YcmlVFgmDLitj2da7XPNFgvKx2foi25M=; b=i6xcibCot16Zj/LA9VF8jQvSgl
	Tel0XDiP69+gv2Z+nfCYce3U8ESfEpewC10yH7fnLRl4fwBUQhw83+6c16NF6is0Sykfh0IvkdKag
	IFZk8g/ESlyru+/TsBRqr+H1BA2J6Cqfp/vB8WZBkV5olIYW1fWE+FgBkZT0dCK/wUPK7Ha78VG9E
	E+yg+Mn/7aoBk8aLgVk3o+8R0cTfkZBHUA+QhZZdpH9/0b11aKFxIlkwETO3aw52k/HZNsiYOa6LP
	IrvmaXTXopyARKVARaEM5uRj1lnAXNqMf20me5fuKv2+khWfIUTmT8l57w18Ud1ycn+7Wryxsm3E4
	47ZGjHbw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wPjOD-003DeJ-24;
	Wed, 20 May 2026 16:03:21 +0000
Date: Wed, 20 May 2026 09:03:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, 
	Chas Williams <3chas3@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Thorsten Winkler <twinkler@linux.ibm.com>, James Chapman <jchapman@katalix.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	David Heidelberg <david+nfc@ixit.cz>, Samuel Ortiz <sameo@linux.intel.com>, 
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-s390@vger.kernel.org, linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2 1/7] af_iucv: take socket lock around
 SO_MSGSIZE getsockopt
Message-ID: <ag3aAv4AV7VXQnKo@gmail.com>
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
 <20260515-getsock_four-v2-1-0d8eed952627@debian.org>
 <ageFn6UV-c-pOPBW@devvm7509.cco0.facebook.com>
 <732d4698-8b36-4803-9c81-ae9865b3f943@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <732d4698-8b36-4803-9c81-ae9865b3f943@linux.ibm.com>
X-Debian-User: leitao

On Mon, May 18, 2026 at 02:00:01PM +0200, Alexandra Winter wrote:
> On 15.05.26 22:45, Stanislav Fomichev wrote:
> > On 05/15, Breno Leitao wrote:

> >> This is not an exploitable bug. iucv_sock_close() is the only writer
> >> of iucv->hs_dev and only runs from the protocol release callback,
> >> which the socket layer invokes after the last file reference drops.
> >> The getsockopt() syscall holds an fd reference for its entire
> >> duration via fdget()/fdput(), so iucv_sock_close() cannot run
> >> concurrently with the SO_MSGSIZE read on the same socket. There is
> >> no other writer of hs_dev, and the aligned pointer load cannot tear
> >> on any architecture Linux supports, so the existing code cannot
> >> observe a NULL dereference or use-after-free in practice.
> 
> Actually iucv_sock_bind() and afiucv_hs_callback_syn() also write hs_dev,
> but iucv_sock_close() is the only instance that clears it to NULL.
> Maybe there is another wording than 'writer'?

Good point, you are right. I'll reword it to be precise — something
like "iucv_sock_close() is the only writer that clears hs_dev to NULL",
and call out the other writers (iucv_sock_bind() and
afiucv_hs_callback_syn()) so the reader has the full picture.


> >> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> >> index 72dfccd4e3d58..3dd11d7a967c8 100644
> >> --- a/net/iucv/af_iucv.c
> >> +++ b/net/iucv/af_iucv.c
> >> @@ -1566,9 +1566,11 @@ static int iucv_sock_getsockopt(struct socket *sock, int level, int optname,
> >>  	case SO_MSGSIZE:
> >>  		if (sk->sk_state == IUCV_OPEN)
> >>  			return -EBADFD;
> >> +		lock_sock(sk);
> >>  		val = (iucv->hs_dev) ? iucv->hs_dev->mtu -
> >>  				sizeof(struct af_iucv_trans_hdr) - ETH_HLEN :
> >>  				0x7fffffff;
> >> +		release_sock(sk);
> >>  		break;
> >>  	default:
> >>  		return -ENOPROTOOPT;
> >>
> > 
> > SO_IPRMDATA_MSG also seems to be only reading the value set via setsockopt,
> > so maybe it's ok to just cover the whole switch with lock/unlock? (will
> > mirror what setsockopt does)
> > 
> 
> I like that idea.

Ack, let me implement it and respin.

> Feel free to split this improvement out from your series, if that is more convenient for you.

That is what I was planning to do, but, it will cause some merge conflict
later, so, I decided to get both of them on the same series, so, it apply
cleanly. Let's try it once more in the same series, if this patch doesn't set
easily, I will split it in v4.

Thanks for the review,
--breno
