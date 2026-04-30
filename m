Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2875342DFF8;
	Thu, 30 Apr 2026 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560187; cv=none; b=cAcuPuthgfKNyyoMax2LUWbK0SSWN9vhuve/NUM2Q0oJwihBWa+NMKG550SxhiJ95JazDkZP5RjPvjHQVhRA6cg0SQdvfVYoTjcOFlsiXszzfPr7+A5rX+DnZW51rq7mA7i8+kiIn4TUqOPxOyts/I12eqVcM90cppYQItjPnsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560187; c=relaxed/simple;
	bh=h/WKKcemp057cG40uVl4sE71I2i0SBZGaW8QyuvigKQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EoH97ZAFGYVNWgyDzgI9YQnxOONQidrz4K7EtVmkiyNUhikKO07+iV9722CwmYvpkmHN+lFmB5eokPlhhd32xlSkeCWb56yts8j8Pp3yl7STVwBvASGQK+lXEfwDuEzrj3vHsKYSR8o8oZZDJRdHJlqclvmK2ce9gmACmyA+4Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pwKOMqKa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pwKOMqKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E45C2BCB3;
	Thu, 30 Apr 2026 14:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777560186;
	bh=h/WKKcemp057cG40uVl4sE71I2i0SBZGaW8QyuvigKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pwKOMqKaMs5ZN59XzN2Tl5DiIMejocs/W0luvr63InSxlknAt0xys1j3BHAaRr9Vw
	 l1C8Qr9SSEy0e+K4oqj7P5GYjfCr5FRzqr0rzHuz98tXX4aKyHWWmD4uhoaBwBK4Qb
	 A6hoXEDnzDeixmzjk85z8T/5ypzpnetrJXG57ciw=
Date: Thu, 30 Apr 2026 07:43:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Minchan Kim <minchan@kernel.org>
Cc: hca@linux.ibm.com, linux-s390@vger.kernel.org, david@kernel.org,
 mhocko@suse.com, brauner@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, surenb@google.com, timmurray@google.com
Subject: Re: [PATCH v2] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-Id: <20260430074305.9d3389ed71af040acfe222de@linux-foundation.org>
In-Reply-To: <20260429211359.3829683-1-minchan@kernel.org>
References: <20260429211359.3829683-1-minchan@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 14:13:59 -0700 Minchan Kim <minchan@kernel.org> wrote:

> Currently, process_mrelease() requires userspace to send a SIGKILL signal
> prior to invocation. This separation introduces a scheduling race window
> where the victim task may receive the signal and enter the exit path
> before the reaper can invoke process_mrelease().

Does process_mrelease() have a manpage?  My googling was a fail.


