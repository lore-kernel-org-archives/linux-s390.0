Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8717625C;
	Tue, 25 Jun 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328139; cv=none; b=HRgYETYiiJScRAVcnCqDxT1KbItM6MiQDUBGoWAMNv++Oja19qsOCG1dZPUN8AyT7c90pqRYhc0i3RXEIKDIA9KoO5zgIpr6EEmkwQkBIrlbUeZ90DDWgN0T6O9alFB0hbhqxZI/hsGdxWsBtfE5YYEzAJmCHzAe063c3+HhupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328139; c=relaxed/simple;
	bh=4BM+dW7bN2QAVhvQz8b/NJBQ+zu2K+L+6llL+5996MI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyNOrOgV9FQzsRWrlLIbb7eN3fO3T7YbrlUHr3p/0tioSirVHxn6hWfYC1NJx1z0qwSqQcIlp9gtRAyCVjxB7wA2Wdrb1b9xApJsnGKWw+xMTWCCOICxwUyGPAXE4ROkXDzkx6j8+wyhwHUER+BZkiVckqYogNH1eosGq1se3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VC0V27hb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC0V27hb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EEEC32782;
	Tue, 25 Jun 2024 15:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719328139;
	bh=4BM+dW7bN2QAVhvQz8b/NJBQ+zu2K+L+6llL+5996MI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VC0V27hba5xYtjw4FGzUNmoTcOR0ttg+ERozLjBI07fWZmH/j/lTelZCLvk0+8fo1
	 wjLAoYyQwuXSqy5cfA90p8Wa6qGXT8Wj0TiHd1ToweuOB5FF6dmuvLij3BoTSk0UQj
	 ERLGQZ9a5LFLj5xScESFzRn/NT4aSXxm6UQ7he/lGwcTm0ZLlVgpT4yPD1cWxoH9ij
	 FeggCmJMMK0bfszESJvsD5VzBxo72sJaFZmfqzJfiJM8y4qMznAJq2RS7WvHynAdwu
	 nbheXs6kl/W7fv4RxVigVVLosdIlFvBCIMSEzMBpzNFbn3hgpkQRJ5b2W6K+z6pLcS
	 mKlBK9rS1wAdw==
Date: Tue, 25 Jun 2024 08:08:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Yunseong Kim <yskelg@gmail.com>, Markus Elfring <Markus.Elfring@web.de>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian =?UTF-8?B?Qm9ybnRyw6RnZXI=?=
 <borntraeger@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Sven
 Schnelle <svens@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
 MichelleJin <shjy180909@gmail.com>
Subject: Re: [PATCH] s390/netiucv: handle memory allocation failure in
 conn_action_start()
Message-ID: <20240625080857.46653437@kernel.org>
In-Reply-To: <6a4b95aa-f3d1-4da1-9017-976420af988b@linux.ibm.com>
References: <20240623131154.36458-2-yskelg@gmail.com>
	<bb03a384-b2c4-438f-b36b-a4af33a95b60@web.de>
	<880a70f0-89d6-4094-8a71-a9c331bab1ee@gmail.com>
	<6a4b95aa-f3d1-4da1-9017-976420af988b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 11:08:49 +0200 Alexandra Winter wrote:
> s390/netiucv is more or less in maintenance mode and we are not aware of any users.
> The enterprise distros do not provide this module. Other iucv modules are more popular.
> But afaiu we cannot remove the source code, unless we can prove that nobody is using it.
> (Community advice is welcome).

If you have strong reason to believe this driver is unused, and can't
find any proof otherwise - let's remove it. We can always "revert it
back in", if needed. We have done it in the past.
