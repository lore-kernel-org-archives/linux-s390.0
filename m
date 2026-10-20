Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459944;
	b=h0AY5TcxGdLZXZsXkWTyvpH/4/Ba65nZadafqomOTiXYhbBXjiB67+iOUm3wafDix4PL
	 7Qf0tdpfNJQrOw7E0v/qO6G6nlW8MJKtyOaUwoYRzJwL/DR7k4R64wwy8vjsk3JmVhAC5
	 bR3yLNnj98aEhGZvSeMjrPhZywZ7wd79K24HEEUHAZHFVlle0PioARWImlbT6JH5+/Op/
	 GPRvCqeWIWVA0dG14Xj5ybjYJo7B4D+/a6UoAHqOpRHQhYI9qrRjsO8oN+fyzXlIsMkhb
	 0uhp1tsa/9mitCqs3YJGkww5Q04Vns5B9bmOUO9Wnm+FSVWQmW3jmE3VEeouBfyfsWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459944;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RHHZce2bisqZNUvfZX9Hgcl7uv7oyGBAYDbe5ybUc7g=;
	b=l9+7a2ceEPug6ofE2ZIkInb7iv2x3durGq3z4GkLSAwarLDCOo7+L+XcQ7DhCN8fgdVM
	 8Qiu+F5ptXKYIsNkAjV0HRELhEGMSUN2jpNRX00MpB+NwiPGM31T0dZn5g4+Zxpq7x0PW
	 xPc73TSiV/NuHfMk8+D52vW4CA2SkFhcRcxu5gFErZaXoaG4nyLDD0HYtTR1QVHl6l4BH
	 SSw13QReMk/9dSg7w6H++OmmnBilB7To0r5w67/FWMjzAjXIy8f+dM+WN6sfIvotlz4ah
	 Q72gLBgddlNoKZXQFl0evQhHteotWiOsRBt1Ywi3QdACSHq0Aiuu9olGc0uphlzC4XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9fyw9BW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA8606A319;
	Tue, 20 Oct 2026 01:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9fyw9BW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4FD1F000C4;
	Tue, 20 Oct 2026 01:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792459944;
	bh=RHHZce2bisqZNUvfZX9Hgcl7uv7oyGBAYDbe5ybUc7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m9fyw9BWEA2jRonWWI+6v7nTpS04pSAddzT88+LEFIeWb1PsUprhO9zMQPc1zK5WD
	 SLSMsRI93ZzBBzkgyACFkTLREk9zB4pAynyKUZHGnAEC3XmTexo84HVMnzdxnVEHGD
	 EuKtbZtUeN9N1VXkAhGtQ05T+JMTCPGXLqEziTp1aMO4IAyeuRES27cIlcC18cgRop
	 Or9cL5mJel0UWcFbcNLQcGi0CHLDkuasEC0Hd5J/NPO0uBaLM+dA7zh08cJGwc3BJ/
	 kHjmU4mnnjF9nbiFflwky6Ch4sDqy6Y5cG3tv12HZHAtx4ngFIHvtF0JTn1m0WnJ9/
	 mGP5uyJ7A0/mw==
Date: Mon, 19 Oct 2026 18:32:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: hexlabsecurity@proton.me, Paolo Abeni <pabeni@redhat.com>, Thorsten
 Winkler <twinkler@linux.ibm.com>, Eric Dumazet <edumazet@kernel.org>,
 Alexandra Winter <wintera@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, Nagamani PV <nagamani@linux.ibm.com>, Hidayath Khan
 <hidayath@linux.ibm.com>, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/iucv: serialize HiperSockets receive with
 the socket lock
Message-ID: <20261019183223.49a59d6f@kernel.org>
In-Reply-To: <20261011-b4-disp-410518f4-v1-1-753bf3258292@proton.me>
References: <20261011-b4-disp-410518f4-v1-1-753bf3258292@proton.me>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Oct 2026 14:08:17 -0500 Bryam Vargas via B4 Relay wrote:
> +static int afiucv_hs_dispatch(struct sock *sk, struct sk_buff *skb);

Please reorder the code to avoid forward decl, please respond to AI
reviewer's feedback. Please trim the slop in the commit msg and notes.
-- 
pw-bot: cr
