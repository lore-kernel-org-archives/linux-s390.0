Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B424EAB1
	for <linux-s390@vger.kernel.org>; Wed, 28 Jan 2026 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769588627; cv=none; b=cUeVTdPOM3I0gE8DOUS0WhAr0Ae4272+vfbVI8D0WEQMP406eqOvC9ShvkEIbJa02OJrubi8OwDBzEmK7iiHCjDNiDCWFfvA+krrhIjOZvJsWk4Z8bSVO/lZEwHO1F3EJCNRJ7gFh8Rnq336QyBhNGoMAy//RBjzPz7GMJVSwes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769588627; c=relaxed/simple;
	bh=RU8Iw9jyO/KeaHBbMqxDYvuJPByiYs4eSn//wltYi+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfLNqbX9jS1BdS0gJ4P7+rRHI5EsCLm7GnR3jQH1fTGlmWSA2iMGhsAuS0tPj7hbaJfEcFDG3eWq/yQef1d+q+Yc8/gVfADINxQQs/VferLDCV5dws63gD/9eTEFm3lKTeFNzdwtMga+ukIhRZ5jtBsDDMA49VL7wp4AQ1TwGY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dxq5DrV2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QmtDu4+F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tfjmv7xy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yuunvSx2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dxq5DrV2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QmtDu4+F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tfjmv7xy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yuunvSx2"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD58F33AAF;
	Wed, 28 Jan 2026 08:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769588624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHSzVwWdvn/v1qjicHUFj5L2t6Mur7psFdUZyPLwhl4=;
	b=Dxq5DrV2Gd1u5jSJDQrxGaxCwfufQqCOlWlGlFbeiEESvIwoE5Nff9nt1vKoDOWVW6buMX
	hxgf3uaY3UAs1nWGOywp8cn7JDX1AP56jchndt1Sni5F57QzYOrDLkrA3HroZ+W0WPfdIw
	4YDierQaIwT1Qr/1Nv1dl8OUtffzcT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769588624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHSzVwWdvn/v1qjicHUFj5L2t6Mur7psFdUZyPLwhl4=;
	b=QmtDu4+FIX1BN3c1alia7HGVsjhAmoEPZEUQMClK4/tinRoxUI04gaGX3oXaWZEcQemkjs
	o74NAXLCI5i0b2Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tfjmv7xy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yuunvSx2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769588622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHSzVwWdvn/v1qjicHUFj5L2t6Mur7psFdUZyPLwhl4=;
	b=tfjmv7xyyVac7rjNuR1OcJ30gjnqmTwhDo6Z2YK/H0NG/ellde8WMSfoT9gWcGvZbFxqPZ
	rqav/PX68wzSE13M1RqTMJRSlKHETvcPYGHr1KXGHg/CX3U/0HZvGQVcf8LKRWqNaofFCj
	M05wQCOpFKdJfC6mmj7HH9RIdg9rt+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769588622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHSzVwWdvn/v1qjicHUFj5L2t6Mur7psFdUZyPLwhl4=;
	b=yuunvSx21pX787jf0t0I2HqhTvSK04AAE5CHJ52LPruvSUtHPmGrbRtf9TOCJ1UiAwe1bC
	6h7KY1dFZLnQIkCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 512A33EA61;
	Wed, 28 Jan 2026 08:23:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e3JAEo7HeWnRGgAAD6G6ig
	(envelope-from <sjaeckel@suse.de>); Wed, 28 Jan 2026 08:23:42 +0000
Message-ID: <d6e511fe-d1f6-4076-8233-4dbafb6ff49a@suse.de>
Date: Wed, 28 Jan 2026 09:23:41 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dibs: Re-apply lost patch
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D . Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sidraya Jayagond <sidraya@linux.ibm.com>,
 Alexandra Winter <wintera@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>
References: <20260127161611.2228083-1-sjaeckel@suse.de>
 <9e1100d7-87cf-4fd3-9840-028e63ffb184@kernel.org>
From: Steffen Jaeckel <sjaeckel@suse.de>
Content-Language: en-US
In-Reply-To: <9e1100d7-87cf-4fd3-9840-028e63ffb184@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DD58F33AAF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Hi Matt,

On 2026-01-27 17:53, Matthieu Baerts wrote:
> [...] see commit 203e3beb73e5
> ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")[...]

sorry for the noise, I missed that merge commit and didn't look at the 
current state.

Cheers
Steffen
-- 
Steffen Jaeckel                       Kernel Network Engineer
sjaeckel@suse.de
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: J. Jaser, A. McDonald, W. Knoblich
