Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019054E50B5;
	Mon, 28 Sep 2026 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608783; cv=none; b=DrU7XYd2eWtMEG8gqdEOb9YwlP30/Ou8Yt2lUeyuv9ODD2IFcc47wYWiHOGAhWgX0b5jHHLBhC62nIKfpWTZ7pThr8L1Vkm4TPbIzbvNSKmHSnxwrh1inu8Exa09RZaXeoMI1ckWD9qpsnCvFBpz38BP7+G0OacwLjLL+GlCr00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608783; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SEytenFioYuFlywoB0PF6PhdISkPvaBVwPTMkyaUgz3XOBHMy5dkwcg/aMchF6gBppY23gjn7TJIzzmVb58Pig3RECBA9K5enMxL03r2ilbwgWWicujEVLHFq5moZmM2F5Rlkt7jyi+gGZQsqGDrdzRYgA4sKSbOG5K+4vPnQrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6Zf0kR9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6Zf0kR9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925C61F00898;
	Mon, 28 Sep 2026 15:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790608781;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N6Zf0kR9t/LFK2I0XcFWXeExG6TCH1OX4UGUV8iqAsPpU+DP1BO9d1E5rBvPZ2YBi
	 WYA8U82PMJORLgWum5bNuF4e609kw79B+0QNnvXHgjqLyIUvyuWKYmjEf5WfE6cAz4
	 wTaskgac7ToqOpgQZaVXSc2UhX27X/xG2seB3mhsueB3cm4sd9GK5XChKbel9aX4xt
	 9/xpLjRqfLNBIi8xRsXHBL/Do4Mb2a6jBkJsADkZdTY8kvkQLYlcWIfG5AFXFVZQWb
	 GFdgmBGuNqrItrF1aMaAErbZ/f4TdbwAAp6xTQA9dwQDhxVxsEE/USBs17/lZ9Tydn
	 ZikV82YEryfJQ==
From: netdev-bot+sinfo@kernel.org
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Aswin Karuvally <aswin@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Julian Ruess <julianr@linux.ibm.com>,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] s390/ism: Zerorize dmb at allocation
Date: Mon, 28 Sep 2026 15:19:40 +0000
Message-ID: <179060878011.31693.9560616938197921438@kernel.org>
In-Reply-To: <20260928151420.383105-1-wintera@linux.ibm.com>
References: <20260928151420.383105-1-wintera@linux.ibm.com>
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
