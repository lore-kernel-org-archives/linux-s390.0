Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1DB3E95A4;
	Sun, 13 Sep 2026 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789306935; cv=none; b=Duv3qaZCGBl/HA7FzCTa067vhkllSIJCpYmDXIKa/Jt+o7lDlIC+/K0BzM1FGK1LoxGThj0obN0InuAMH7q1VBvwtMAV7vHVQMCRnCHZ8m88k/p3qHQoyq49Dq2l2p9qOTvMR2+VyXzL7HyJ0iMQbJ7XCZhoFBFxoOjFQYIm364=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789306935; c=relaxed/simple;
	bh=qw1xHlLC1kd9zAg4aJ1W9KwYg+qMtqtlgmbzsI+liBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9hYZ1ZOeKrgaW70luTdmShvmjde4hnsqRNMzzscQHWpcycct+SwUrX3ZoGDEx8WeSHPTnUVJR/PMHMMla97/BODaEG8wl1940Rv0WTNKYxMv0E3BrNGOSE0WsqWEMeGxv7UFOifg13QpFhCtjC0BK9pYYod0ERvOqv0uH8c3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haxNCA7H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haxNCA7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B2F1F000FF;
	Sun, 13 Sep 2026 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789306933;
	bh=clOtLojCrNukAya+E6PjcXvKk05cUYZKgbxNeWffo3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=haxNCA7HzKRd1yAVHFvEqxwHi1ipgIv+uCdL6v44KtgHMQ2Gd45KTHm0zpeYCtH9D
	 SR0amQncA0VWdlu51QId8lONmv8LlGLcbqv7/6kQ98LP0nN6VFRUcEspl2q2WBG6Jk
	 QKHHNKp8PtxOtta70e6HwLpVLpqxBe9gGtaBCsCwCzcBOi7siemZOfKUO9ivah3F7V
	 32R953XHjce/HW27n1a+YIMSDFNbHREo2wB1HNR9zFzSk8IHWKWM3Zzdn9w3nm1ekQ
	 7DTUeSiZUl9+arzdrWCxphtNei+NgC3mMgSoiWbB2rOAflUDxTI52yKBTQddZ8mmdj
	 q8uXVK5W1LAVQ==
Date: Sun, 13 Sep 2026 14:42:09 +0100
From: Simon Horman <horms@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Alexandra Winter <wintera@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH net-next] net/iucv: Add lock nesting annotation in
 iucv_sock_close()
Message-ID: <20260913134209.GH48209@horms.kernel.org>
References: <20260910162919.2100124-1-wintera@linux.ibm.com>
 <20260911162945.B92321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911162945.B92321F000FF@smtp.kernel.org>

On Fri, Sep 11, 2026 at 04:29:45PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Lockless traversal of accept_q causes list corruption and use-after-free due to concurrent modifications from softirq context.
> - [High] Newly allocated sockets are permanently leaked on error paths because iucv_sock_kill() returns early if SOCK_ZAPPED is not set.
> - [High] Child socket leak in iucv_sock_cleanup_listen due to late state update leaving a race window.
> - [High] Unprotected state modifications in iucv_callback_connack cause state desynchronization.

My opinion is that the issues above are all orthogonal to this patch
and should not block progress of it.

...
