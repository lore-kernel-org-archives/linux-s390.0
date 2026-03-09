Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0987E349AF5;
	Mon,  9 Mar 2026 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091796; cv=none; b=kMTzCLSS1YERiKKiEqrwSHTMV5zWoLk/wWCIxXIDgIGf1zDTO/fE5bl70TvrhR2ZYiZhtxF1AIqgM4Kfrtye+eR6l6VvyLjthc0NWhnmAdcu/W+jKfko2wd9C/KCAWpp7sAJG24HqqhJbYUlSwUHahZSavTP91WrnH2caR241lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091796; c=relaxed/simple;
	bh=dlZ+cYzjAVo9R0VWTOYYhJLvWL2hlTOrad+GmSBnVSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvXSACyh/DZgG4trOa12WobSyRtkwz8WeOprMW4UCYQkzQSC9IT+74IMFXByhsRrNjuyK++OUzw5hqr1WjX02ebZsQsjpov7f4mxV7ZSUCC0KWOyFdH4q9s+g36+QXV8mf3zqsJs6eLg/obwBFf5/ovJDPjWFK37jcTXIp+IxIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3/uicOT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3/uicOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6059C4CEF7;
	Mon,  9 Mar 2026 21:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773091795;
	bh=dlZ+cYzjAVo9R0VWTOYYhJLvWL2hlTOrad+GmSBnVSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3/uicOTsDKsMaKy7R9/QUtYshUxWJBEDQwtzxfFYZSOYp7emjBBTyp8sACuA41ZA
	 uFsGingtwi4ZiWmLejlxSqNUNkNjw0whzlDh+lCbwMs55wI53/YT1Ff55j5rftp6o8
	 oOrwNy0ee74jJWtZQbwM9TrIfiZrkgU3VAO6WCMPwrogviRRnIDsz2jXaiwdXTArip
	 BUHMPgdDsJNuVgfrO91jO0Ue3qKjSl2/hysZ/hpLXypw3NvAf6W0ThbXJWgjEE6KbB
	 fi8jmiRwgeznkfplbkcSANyKgAHU4JnbCic2pM968DnfoezBirmtWFcFwsvpUbx59O
	 XpdOdy9PYrhUw==
Date: Mon, 9 Mar 2026 14:29:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, Coiby Xu <coxu@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] integrity: avoid using __weak functions
Message-ID: <20260309212947.GA4150408@ax162>
References: <20260306150421.270124-1-arnd@kernel.org>
 <20260306225648.GC2746259@ax162>
 <abb4d186d1ca76c080d5e15bcd9e0019cce3af39.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abb4d186d1ca76c080d5e15bcd9e0019cce3af39.camel@linux.ibm.com>

On Sun, Mar 08, 2026 at 09:01:58PM -0400, Mimi Zohar wrote:
> Thanks Arnd, Nathan. LGTM.  Nathan, could you send a patch with a proper patch
> description.

Done, thanks for the input!

  https://lore.kernel.org/20260309-integrity-drop-weak-arch-get-secureboot-v1-1-6460d5c4bb89@kernel.org/

Cheers,
Nathan
