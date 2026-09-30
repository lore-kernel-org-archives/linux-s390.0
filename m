Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F9D78F3A;
	Wed, 30 Sep 2026 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752192; cv=none; b=BvYaGueJl3Fhjmn4/yqVXsR8xh4NMSjJx9k4UqbVTbz+Y1GXhPeZELPZX40fezxSh3cE75u+yy9hKqmRnzvIUpbb6azNXqV3UriMZxbhwQ2w5kcMvvg1wwlr6fIsyfSBW3C/uzpqagTE221K4JXwRtvpyrs65Cc1eM+jqp98uWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752192; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GeKDSbDkP1YLSgYp+ep4iwlR6B7LVRBeqIw1AfKQYWp2HzSinwUALC6E4Y1N774KeeWRB/D/1QXQFmShnYleI0kTVb+IbHkftLNVbKLYf+t5AGhuWCqV7AIDsTLnokNNgWx45fG2OAYTHTnVLRy9ybbmo1kCwTBgEBmKEDSGf5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5spMLJw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5spMLJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098F41F000FF;
	Wed, 30 Sep 2026 07:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790752190;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U5spMLJwQW8+dqYf1ojw4ZfbiePSiWYMe5W9TPZxE6vawrAAuvtr8E+0s1R8I1+RZ
	 78feOEBGYfqTMx72mXsygAA87DS5prpCX28HbicXsNR/1gsMWbwWYuU20R/WO3fLzk
	 LPEa8HGlFoYcVuOMMxK+T4GoSmJCjw+Ua/OMMkf9KhPxM/G67ABa5NYLjBnoGhCy3J
	 wn7TFWeHc58EW/+2Ou2uWUMgBqTMd/IxcxUprbZUoJ20OroK+wbHintIKafZjWFuJ5
	 mQwrpPdfpZFFkIBow+Y9DjGsOqpbua7Wm6MoJMtp+B4MtEffJWzBi4x5IzPfmZfmua
	 J//1PfLWddDdQ==
From: netdev-bot+sinfo@kernel.org
To: Nagamani PV <nagamani@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wintera@linux.ibm.com,
 aswin@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 kees@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: 
 Re: [PATCH net v4 0/2] s390/ctcm: Fix timer corruption and use-after-free
Date: Wed, 30 Sep 2026 07:09:49 +0000
Message-ID: <179075218956.31693.13833464260090345125@kernel.org>
In-Reply-To: <20260930070234.569500-1-nagamani@linux.ibm.com>
References: <20260930070234.569500-1-nagamani@linux.ibm.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
