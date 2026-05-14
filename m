Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1600238B7D2;
	Thu, 14 May 2026 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795418; cv=none; b=YFBGv6dI3sIvIa2bXHq9/FYhdjIZC0gG4T4QT2s8mZ7TCepGSJVlxBj4tEpI5w88tSjKppBQ7oWuTF6jE9IaknQifo9VZs5CjxfduAsMj1HTmKm0BSkWK4qlBF35F6M4aHfqPbJMAL7oy8nm8TMgsd52/JLr+vb7aJ9ehusvP1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795418; c=relaxed/simple;
	bh=L7Ez0iCQC+05BbsOTxEjlWXKRJ4hPTpPWBaZww8I3wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdCsJHY9j81hoVObxasOP3bHeR8gU6DA2a+Dyvh0fP+oaCBw1Z1UPlcjzyqUlhwhosx7WBWF3OVTTVorvrnFqLexuXKvjjZPDbpUpzUToH3qYft4V1jVonTlO3dHhnVeyHl+I3i3v3E6GRqRRdSig1f7iwZQft/Zi8uEbgH2UFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c21uPsub; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c21uPsub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F6CC2BCB3;
	Thu, 14 May 2026 21:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778795417;
	bh=L7Ez0iCQC+05BbsOTxEjlWXKRJ4hPTpPWBaZww8I3wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c21uPsub557efwmh+L/O7rOj/eP5vUrJklcFxPiHcKwpO9+TuFlB1JFR76efGNHkl
	 zzopvWhRp6pCE73nFm75CJzCXTQ7zZ3TftFZ8/Bp83sAPradO7M3D8VAu7DlkdTQKa
	 1MZVTYeyoSl5YcwQSAoPJLh6A1xROz655vUpdsBUMz7sNY3f8+p8wHijv42jmiPUE6
	 nUulHHPtyLXKCvlH/awPftkzsQQMXQ9TDfQS+l/4Tf+KOEdcbCqNys0rzAOOlc1+lz
	 MoMbT99pFNxgR/arxCB9zGdU2Rci9qIkOvVQxUnJ3O2a+J70KMWKR4aE97I5aiV0Cx
	 e7daomm47AixQ==
Date: Thu, 14 May 2026 14:50:16 -0700
From: Minchan Kim <minchan@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, akpm@linux-foundation.org,
	hca@linux.ibm.com, linux-s390@vger.kernel.org, david@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v2] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <agZDmE70VHiyKfXI@google.com>
References: <20260429211359.3829683-1-minchan@kernel.org>
 <afMnKrYT0xG_a-b3@tiehlicka>
 <afUYfpwWsUQoB9hz@google.com>
 <afhQB0CWEcflXpOi@tiehlicka>
 <20260505-wegbleiben-deshalb-f929089dbdab@brauner>
 <afoUt3te1k2TNao-@tiehlicka>
 <afowD31YsGVdVUBP@google.com>
 <agJN2esiIGIhUlMG@google.com>
 <agQeABD0W7wn4pCt@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agQeABD0W7wn4pCt@tiehlicka>

On Wed, May 13, 2026 at 08:45:20AM +0200, Michal Hocko wrote:
> On Mon 11-05-26 14:44:57, Minchan Kim wrote:
> > Posted v3 - https://lore.kernel.org/linux-mm/20260511214226.937793-1-minchan@kernel.org/
> 
> Is there any reason to fragment the discussion into yet another email
> threat? I believe Christian is still catching up after LSFMMBPF last
> week so give him some time to have a look at this proposal before
> sending yet another version please.

My only reason for sending v3 earlier was to demonstrate the exact code,
hoping the concrete implementation would clarify the intent.

I will gladly wait for his feedback before taking any further steps.
Thank you.


