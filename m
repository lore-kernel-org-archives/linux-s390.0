Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37866FC5;
	Wed, 13 Nov 2024 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522071; cv=none; b=HxWIIS+NqAQaHu6bIuf97dbni1pLAbucZmhIEwtwK+sKW7F6xf+oGnu00DacEFX8xjw/Yeol4KWBeB0NOVeaU0G2oZDNTwQbrFjNRhADf3Pslajn5KjiievEbz08yUiSf0q6YqyJmUc/28GYsSFPm3OruiVzgoopieMz0Knw2AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522071; c=relaxed/simple;
	bh=CTwldctg5Cu9Oulth5HBZldCUbDkKQugx9mEgCxO5H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LspGciWWICXA5RjWLac/J9XaPEeZbm5VefhXeVM6hhdyz0VAHdkoMdHke1r106tjzyIWTaBVGT9h36N6rWX5eYBbBDl8YaOgxtk62WUHG9YBWppaGaEqD0rHhX63CWpbIac3XwcuymL2L9te57hZCnAPGi06WmUHpgunvm6G/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lszNiP/L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lszNiP/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405EFC4CEC3;
	Wed, 13 Nov 2024 18:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731522071;
	bh=CTwldctg5Cu9Oulth5HBZldCUbDkKQugx9mEgCxO5H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lszNiP/LjLULDQrS6+bV7NWVajJxjFXkPWKIZx5isNWd8VzQjpjnm6V4pU8qvuYs9
	 MkZ2RQhWwPV5ehBKyQ/X72ABK34o1u6wFtXWheLNNcAqyXH7yxyiCWjvKc5MADyFXW
	 t3dRjttQADQ0Dj0jI575/xxLZux68z0xMhUPMuKfL4BdN7WT80Hb6lUDVzQtsTitad
	 r1Xk21Ip8PupZBqWhvSenPNL5orJhhEvcBqCOTGVzoh6IFV/kPtbM3N+g3x5oatb/Q
	 b4aOGzOC/7FGQo58x0GucbJFEoLPhT7YPzVEp8L2sQicOCMbYz3VrD0SOaHLJoiGV3
	 8qrrRSmYGP8vg==
Date: Wed, 13 Nov 2024 11:21:09 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 1/2] scripts/min-tool-version.sh: Raise minimum clang
 version to 19.1.0 for s390
Message-ID: <20241113182109.GA3713382@thelio-3990X>
References: <20241113154013.961113-1-hca@linux.ibm.com>
 <20241113154013.961113-2-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113154013.961113-2-hca@linux.ibm.com>

On Wed, Nov 13, 2024 at 04:40:12PM +0100, Heiko Carstens wrote:
> Raise minimum clang version to 19.1.0 for s390 so that various inline
> assembly format flags can be used. The missing format flags were
> implemented with llvm-project commit 9c75a981554d ("[SystemZ] Implement A,
> O and R inline assembly format flags (#80685)").
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Oof, this is quite new but now that kernel.org has LLVM binaries
available, I do not think this is an unreasonable ask, especially if it
makes your life easier with code maintenance.

Acked-by: Nathan Chancellor <nathan@kernel.org>

One question: Is it worth dropping the mention about CC=clang for
clang-18 and older in Documentation/kbuild/llvm.rst? Maybe it is better
to leave it around for a bit just in case people read the newer
documentation while working on an older kernel?

> ---
>  scripts/min-tool-version.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index 91c91201212c..2dc674a74624 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -25,7 +25,7 @@ gcc)
>  	;;
>  llvm)
>  	if [ "$SRCARCH" = s390 ]; then
> -		echo 15.0.0
> +		echo 19.1.0
>  	elif [ "$SRCARCH" = loongarch ]; then
>  		echo 18.0.0
>  	else
> -- 
> 2.45.2
> 
