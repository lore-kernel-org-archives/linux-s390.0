Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B0938E8B8
	for <linux-s390@vger.kernel.org>; Fri, 15 May 2026 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877932; cv=none; b=QImjYh2E283x6NkngSIFxBm6s38PNGRpiCatCbGHIZ53nSROe0leiBM9PZX3lDFjgFvCRKvCNPh5tSDCLJv9gg4LCULgOBoPDHEgMzaWoO2vPEcyDTWgqZtLytBf9b+NaE5SgsojF3SFuv76pvBefBHMLfcmA1Z6bB2PBaIYpio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877932; c=relaxed/simple;
	bh=jYFCW0q2oH14t/Tdq68TImEf4QAJ0L7oEU4dKSkZpjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KALkBhISp8SJcblNFTxDVIQpZBUHr2JgEfnzCSualaVJdPc2nFDJAzUWxyeJrm4jNzZaKdS28MHpZgUw+5QpHgS5NlhAVJWMi7TsFuBECiNsDggcGAlBm65oQ0kTQxeaGbo8n3NQOZxWzLo0EzMQjhk4QTguxEoO5XqZhuwF0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/DPFY2q; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/DPFY2q"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so122829a91.1
        for <linux-s390@vger.kernel.org>; Fri, 15 May 2026 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778877929; x=1779482729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Jp3G/+8nHauE/XI0omIm5SsO4BbcTyQ1cU6IXSGwNU=;
        b=F/DPFY2qHcEADU66AoQ/HAiAUlJsUgix7K5w2KL/d345RfzWcZ6/PEzo+Y1thEIbVX
         D6pBggvaMQ4CeZvz4e+7UIecvaw/fDIZTZOkyf4rTCXp8iRSySBbW5Vno5f6XClfLy7Y
         sscb1UyDNZCvN4XOc4pZdW+IpC1S9opSJKuKSfZtVKazLuGgEpBJ2rL4274QDUb86avo
         elS6sVawMNeL20eBSkLQWSVJPwOQOeKdunhYEgARNhF1tAB1DyIDQv4PWfB89guc5O5g
         gcEfpJiN7Fy5RO8kI6D5jH+ss5UEHZ/1xjMKWg0S9lcPhQKlHmRuYKtZ37PYOKKX6rjq
         EE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778877929; x=1779482729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Jp3G/+8nHauE/XI0omIm5SsO4BbcTyQ1cU6IXSGwNU=;
        b=oqqkFjUNS/pPT4CJx9NVjIJ6F1Uu46GSyr62xOrIMUuFY7n2KjhW3mJArwuCuSzKz8
         fChNy6pJnzur09bS5+6vrT2+YRz5cQVnNyItgEIsj1pLeIQC16hYdwboynP95nM+M6om
         P6//ot8a8XMvIo+y06mfE7Smrub3dJHJZlR7pjMarR04Z16bLdgEUkKlCgpfk0cMmDfk
         9VPd+WetYXhgdIhce6A3whqi95//11pMnELnKXt217c34mNBr3OZozSn6eThxaDufN0D
         e9WxO5K1l6Bw0JM6pvmZMfsQFnQvx54M8Xr4i3p9RMqPLUpWP2qrcOjPoa1bzHiHwjVI
         yhEA==
X-Forwarded-Encrypted: i=1; AFNElJ8a1rQ9AiGYo8ylaTajLXGS+dHVfJIkwGFIVu4JwWCMom1J/rHL/0AmZ3InMrvsCgWY0qqzK5S05C6l@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg2Gr//UNzz7w27clDIHReYrjolP+wbLMP5QwMq9ro0aXFsSqt
	TixHAbFLu1INIK//xIvxf4ujp1jfv4DOaeHeuUuzGzeP7hisZFlXegcp
X-Gm-Gg: Acq92OE+LNRdy2LwyWf4W0QIEgDM5XOR+DOoJTK8TplEO5TZz8r02ZMuWxwPQNpArXR
	nLVULN4yet3ygNFmrMR0yf7F2p2AvXmGznRXtTpAtlFspQmRZamgaCgL23rmSjPCxVk8458WrN6
	OS2GhofHj6cLTB4n+G3E0BT075pRQs/aDGyH6oldg2+DXmAa98VM7AMLkWBzQTeMki7nWdE+X3L
	ewHPh6uWr2IY1OVhraATgYvkQOSlFBsgaCgJnv7UWrB/GeQQ8qMmNwsjARVQoq2ZAol5Cq+A/FB
	zkZBLpwxhg6adHsgKPbiUGv+BJtDbAUMIaziWlej+Hc/qRyVMIMQwqdqdMDc2J7j/azjeJf2Gwg
	xi/MhLs8GuxlBib0BG3XLvmX+Rvk4L8kF7536Ob+0lLAUjs/xvLfl5SaknLwBvBu1386/Zl05hb
	KNry5136OEJYz19y0r
X-Received: by 2002:a17:90b:1810:b0:35c:cba:3453 with SMTP id 98e67ed59e1d1-36951ca602amr5899046a91.22.1778877928785;
        Fri, 15 May 2026 13:45:28 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369703bcc91sm167683a91.3.2026.05.15.13.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 13:45:28 -0700 (PDT)
Date: Fri, 15 May 2026 13:45:27 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
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
Subject: Re: [PATCH net-next v2 1/7] af_iucv: take socket lock around
 SO_MSGSIZE getsockopt
Message-ID: <ageFn6UV-c-pOPBW@devvm7509.cco0.facebook.com>
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
 <20260515-getsock_four-v2-1-0d8eed952627@debian.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515-getsock_four-v2-1-0d8eed952627@debian.org>

On 05/15, Breno Leitao wrote:
> Mirror the locking used by the SO_MSGLIMIT case directly above: take
> lock_sock() before reading iucv->hs_dev and dereferencing hs_dev->mtu,
> and release it afterwards. This keeps the two adjacent getsockopt arms
> consistent and matches the lock held by iucv_sock_close() when it
> clears hs_dev.
> 
> This is not an exploitable bug. iucv_sock_close() is the only writer
> of iucv->hs_dev and only runs from the protocol release callback,
> which the socket layer invokes after the last file reference drops.
> The getsockopt() syscall holds an fd reference for its entire
> duration via fdget()/fdput(), so iucv_sock_close() cannot run
> concurrently with the SO_MSGSIZE read on the same socket. There is
> no other writer of hs_dev, and the aligned pointer load cannot tear
> on any architecture Linux supports, so the existing code cannot
> observe a NULL dereference or use-after-free in practice.
> 
> The change is purely defensive: making the locking pattern uniform
> across the function avoids surprising the next reader and removes a
> foot-gun should the close path ever grow a new caller that does not
> hold the fd reference.
> 
> Note: For the reason above, it doesn't contain a "Fixes" tag, and is
> aiming at net-next instead of net.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/iucv/af_iucv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 72dfccd4e3d58..3dd11d7a967c8 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1566,9 +1566,11 @@ static int iucv_sock_getsockopt(struct socket *sock, int level, int optname,
>  	case SO_MSGSIZE:
>  		if (sk->sk_state == IUCV_OPEN)
>  			return -EBADFD;
> +		lock_sock(sk);
>  		val = (iucv->hs_dev) ? iucv->hs_dev->mtu -
>  				sizeof(struct af_iucv_trans_hdr) - ETH_HLEN :
>  				0x7fffffff;
> +		release_sock(sk);
>  		break;
>  	default:
>  		return -ENOPROTOOPT;
> 

SO_IPRMDATA_MSG also seems to be only reading the value set via setsockopt,
so maybe it's ok to just cover the whole switch with lock/unlock? (will
mirror what setsockopt does)
