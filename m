Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63218F;
	Thu, 14 Dec 2023 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOrmA2DE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92049C433C8;
	Thu, 14 Dec 2023 00:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702513736;
	bh=tQFwrDCOk2a2q/qZ8qSubMnw90hcJ8c+fZRXDcJTQnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BOrmA2DETPhEo6BqgDyhgelgOXer2LOk5wlznPX5fq2pKPtg/rOzY95+ywP/lofbD
	 XA/fl4wEoI/vI18t9RiZ7FRG/OtxjrN1ao+WEEeTWUt7gA9R7FUxk//dHeQrs9vqWX
	 0TmIgQQq1fYZU0vW17gfI9r42EKYlRMWhTe1QLxzAJcaR4bzGCJRhx5glQlEPA+sc9
	 bbXrxMSWfOa6Fjq103NsnxU8AfxU01wHfjyDWoILJPYd63Z0BpYkSeddJhVBpk0FXq
	 iVLtzKf2GQwP1p2dNLFwTP/uMhym2lgb4zFlucctpjIHHPhRxXf8AqK1fUB3zaI8q5
	 8JrCl/zH62+og==
Date: Wed, 13 Dec 2023 16:28:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Lu <tonylu@linux.alibaba.com>, Christian Brauner
 <brauner@kernel.org>
Cc: Ahelenia Ziemia'nska <nabijaczleweli@nabijaczleweli.xyz>, Karsten Graul
 <kgraul@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher
 <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, Wen Gu
 <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Alexander Viro
 <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RESEND 06/11] net/smc: smc_splice_read: always request
 MSG_DONTWAIT
Message-ID: <20231213162854.4acfbd9f@kernel.org>
In-Reply-To: <ZXkNf9vvtzR7oqoE@TONYMAC-ALIBABA.local>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
	<145da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
	<ZXkNf9vvtzR7oqoE@TONYMAC-ALIBABA.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 09:48:47 +0800 Tony Lu wrote:
> Please add correct tag, for this patch, IIUC, it should be a fix, and
> you need add [PATCH net].

I was wondering who's expected to take this. We (netdev/net maintainers)
didn't even get CCed on all the patches in the series.
My sense is that this is more of a VFS change, so Al / Christian may be
better suited to take this?

Let's figure that out before we get another repost.
