Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE2D349CCD
	for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686363; cv=none; b=FY1dal2q7aRDgL0HmCYJFI4pOBX/83UyRnlEwiYM+sj4B1xXPShwxE1pP6tc8iohb5zt1jkRkqBsGSz4Ui/uL9JW3A7oNe0JJ1gIrV8W3nW2t5/v9A598wUy2A4FftNLkYgZKlWE2rWmBz8p+bg3TsnTYDrhIob1hFMluk7u4rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686363; c=relaxed/simple;
	bh=uEdiX3bsYBq/wVfVqaY6nIE6JvVlmP8CjNL6fk0R+S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnbyohNDGF4W2/zb0AOpnhrgWYxspvJSuAcx0FuBB1BjRLxjntRVdvYDk4Qva8RrA4zBq21g/6KkIjmP4j0zmHWs2Yz2xti2lqkCSGwVT8uFiX88+JrCg6NxlNXt2p891oGVmkytj5EQYy8nhY0nfuqekXUW5KfqzQtZ7gLriWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQrO/dQ7; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQrO/dQ7"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3660daea6a5so3814215a91.1
        for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686360; x=1779291160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2C8hObdO8WpevMDGMCA7yvRyBq1XyhuobSazR5gNIQs=;
        b=hQrO/dQ75FkRUjpGtoKNrMBNsuAu5i803NBLZKR4r3tU3e6aOv+MTELV/oWyDab6qd
         BhUo6+VuEOGuuJtkDfegJMOao02B3tNm87chYCdHYs6wmQIkzRGgNmD3MPhQPo9QyQ+M
         Zol5oaIgxL6JybiDuhu4Z16nnxYr55Pe65zE4wNkpQZUx6akqwsqnut1MX+fZNSwiSK/
         Eqqe0asrCPmSTTFZwoTcKXcsCFZgQhZq3GDQ3Ml6sIjegUF5Hq0JxkKwRc/HiiEg0JZd
         U8dfxY4q29axC37VRLN9jmD83QzWeP8AjLkGhfvC4t7DXHucp4a52l3yJpl93BG+L+Pu
         3BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686360; x=1779291160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2C8hObdO8WpevMDGMCA7yvRyBq1XyhuobSazR5gNIQs=;
        b=KTdlCD+uUmcvGYMhi9U5+pbyTel9IQ+bq4eROsi0012gQ7vZpK8GlzaiJbN1lUpb5g
         wYyvky5yB4wcA9C8nJogdDYrnOljgAKQXf9nprAtIAdf1fuVrEQP7cwQ6rwj4ypBkCgm
         /a+U0qk3CoKkKYmuI26QRTRycTMlM6fmVU3PQ6cM0pE59KVXe5HuMQRXMQWY60P404l4
         4AO9r3H6xfgADwYqhIFk7z+Iihflhq1/eglj75hhVlkr32CSFai5jq6C8nw8jPaAyv8P
         HcxpEQQNGkQvCDRSwk5Rru8H1NcFpOybXH/oJHe0YV9glKUGzXl07+x7KDQzjcwNwKCy
         XXrA==
X-Forwarded-Encrypted: i=1; AFNElJ9qA8PACqhGpw+3ZoiEilleb89NiS+aBt6Naa4i2+0HxuIxzVVH9QvjIQbryjJYNetaD8hborc3E3YM@vger.kernel.org
X-Gm-Message-State: AOJu0YxyEG4L9ig1s1BU1XkZthmwozWSlSJz1NpE7JnLHsBMl/gjRJPk
	q6IfqYwhksgycX0ms7AnBBDWNB5W/+8jSL45izr8JxggbU7PCW2dqMUi
X-Gm-Gg: Acq92OE7GDazzVUwvVBpm7+8xMXWWDL6m4euutZUpzK+PVSmE55LX6Jc7z58MpBmFc7
	43jbINPnStY1XzmcVzUoo+ir49bgXkx40H4wB4ciF9XarsgLpA6aGajY6n1RuWGVIoycC0kMWJJ
	KGuSCM8fflM6sg6+sjZxMc3i6zXKd8tD8IjMZwxw9Kn2ete5BHj+AuCWGPpHp3d+tw0DoxHFjRi
	lQj9fBW4HfwS1zihTo8nc0kJlSSRzE4WRoviFUb6Zh13Nu1kNj3U0r35W8sNMsqfBXq5a0fWC7y
	4vqzD4GOs6fg5PM8dK8vlMMTyVt4UEioDgaa8yEHDSFMnwIDl1XEapbmQRw+1Pnh+cy2AnYwql2
	HYGlJxVkssJldxN6cG5KDiw7g4NcIoQhE5fmH7R+RODqgt8zww2ZVB6r5XqWaw8NNqdwMeaCVyi
	/ua+K4y7DkFUoCBGDu
X-Received: by 2002:a17:90a:c105:b0:368:5367:d681 with SMTP id 98e67ed59e1d1-368f782ef5amr3543149a91.10.1778686359919;
        Wed, 13 May 2026 08:32:39 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:54::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ee6280d0sm3409228a91.16.2026.05.13.08.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:32:39 -0700 (PDT)
Date: Wed, 13 May 2026 08:32:39 -0700
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
Subject: Re: [PATCH net-next 4/6] l2tp: ppp: convert to getsockopt_iter
Message-ID: <agSZeMEvxE0xyNB8@devvm7509.cco0.facebook.com>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
 <20260513-getsock_four-v1-4-fe7f0e756fac@debian.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-getsock_four-v1-4-fe7f0e756fac@debian.org>

On 05/13, Breno Leitao wrote:
> Convert PPPoL2TP socket's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/l2tp/l2tp_ppp.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index 99d6582f41de2..4c7a1152b20ba 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -59,6 +59,7 @@
>  #include <linux/string.h>
>  #include <linux/list.h>
>  #include <linux/uaccess.h>
> +#include <linux/uio.h>
>  
>  #include <linux/kernel.h>
>  #include <linux/spinlock.h>
> @@ -1317,7 +1318,7 @@ static int pppol2tp_session_getsockopt(struct sock *sk,
>   * or the special tunnel type.
>   */
>  static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
> -			       char __user *optval, int __user *optlen)
> +			       sockopt_t *opt)
>  {
>  	struct sock *sk = sock->sk;
>  	struct l2tp_session *session;
> @@ -1328,9 +1329,7 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
>  	if (level != SOL_PPPOL2TP)
>  		return -EINVAL;
>  
> -	if (get_user(len, optlen))
> -		return -EFAULT;
> -
> +	len = opt->optlen;
>  	if (len < 0)
>  		return -EINVAL;
>  
> @@ -1358,12 +1357,11 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
>  			goto end_put_sess;
>  	}
>  
> -	err = -EFAULT;
> -	if (put_user(len, optlen))
> -		goto end_put_sess;
> -
> -	if (copy_to_user((void __user *)optval, &val, len))
> +	opt->optlen = len;
> +	if (copy_to_iter(&val, len, &opt->iter_out) != len) {
> +		err = -EFAULT;
>  		goto end_put_sess;
> +	}
>  
>  	err = 0;

nit: if you're moving `err = -EFAULT`, you might as well remove this
`err = 0` ?

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
