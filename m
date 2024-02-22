Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D2B1552E8;
	Thu, 22 Feb 2024 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623449; cv=none; b=V+6COZ6UzYaMS5vDVuNfMmDAl5ohYJJmgSdAZvRUtYVGem71JLQbMsA1ZXWaBuSUjDirri2YkOTpVefXg3xUSgt+gApY6oFlaHkrA4m139FVR0NK8EpASzhdqdtMjWoSkmfBYQm+1W/a6jnpbx3pCrkJPcQH56RToYW9DeUp/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623449; c=relaxed/simple;
	bh=4aCA1m6zjX5GTHoXX3gANY7eBWFjg4DG1dwuyxhRDaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwRAwcVXtNgsfmqjn6A59uiXu0grRuXqby6nuhpGimHinHqiwIRLfMrus/m1OLRkq+yIZvVSBk+nhh7yVcGSCARgOo2K9e8URWIPBcmA13sbnwkd7R+9q79EHq5ySqJVFrNjSk+mVfyZM6jnkeXKaTR4BeesR2cyAyRXKdJDO6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3etoNt1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3etoNt1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22766C433F1;
	Thu, 22 Feb 2024 17:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708623449;
	bh=4aCA1m6zjX5GTHoXX3gANY7eBWFjg4DG1dwuyxhRDaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l3etoNt14xHEolDzDvaLMxoR2iFUCkkPG6G594rf+sGuNQATR/8Xic9AGnGO98Lxn
	 Z9JWa6VszDUunr49R0kA+/GEMh0z1tZFcgNVT0cyurDN4PxPaZvI4aZfywVx/Z6Xn2
	 Lk99Cc+a3sXiKUwbYxTLfM/2EbaGUyIxTSVb7jMTdlw8Y7uHvNjt1Xhgazn2s+bknv
	 ShgJUbB/xIDoE+viFr2grQeUD8TfZ3JxUYxLtUwbvakpKnW8rWYiE2IgcLyZ/ZWxmJ
	 zk1sT+BPo20txx2/IttvEvkS8Z71U4qN6+YfuK59IPOCZhyATMrP7EywRKqQPbejt5
	 sYxL7Ed70Cm0A==
Date: Thu, 22 Feb 2024 09:37:27 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: Re: [s390:features 97/98] Unsupported relocation type: 21
Message-ID: <20240222173727.f74r4wjolrbmnm6u@treble>
References: <202402221404.T2TGs8El-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202402221404.T2TGs8El-lkp@intel.com>

On Thu, Feb 22, 2024 at 02:42:01PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
> head:   4a5993287467d2d0401503256dc9d2690c7f2020
> commit: 778666df60f0d96f215e33e27448de47a2207fb3 [97/98] s390: compile relocatable kernel without -fPIE
> config: s390-randconfig-002-20231016 (https://download.01.org/0day-ci/archive/20240222/202402221404.T2TGs8El-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240222/202402221404.T2TGs8El-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402221404.T2TGs8El-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> Unsupported relocation type: 21

This is R_390_GOTPCDBL, which I believe can be ignored by the relocs
tool since it's related to the GOT.

I'm not able to recreate with my s390 toolchain (12.2.0), but I suspect
the following fixes it:

diff --git a/arch/s390/tools/relocs.c b/arch/s390/tools/relocs.c
index db8bcbf9d8f8..ad3773dc1f95 100644
--- a/arch/s390/tools/relocs.c
+++ b/arch/s390/tools/relocs.c
@@ -276,6 +276,7 @@ static int do_reloc(struct section *sec, Elf_Rel *rel)
 	case R_390_PC32DBL:
 	case R_390_PLT32DBL:
 	case R_390_GOTENT:
+	case R_390_GOTPCDBL:
 		break;
 	case R_390_64:
 		add_reloc(&relocs64, offset);
