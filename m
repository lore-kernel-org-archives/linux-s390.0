Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795266998;
	b=AzNbGvHHy1ehSFjcmkYJI6J220L/ZTJ+0SRP13j87L3UjO/V8YLcigQcLzpds0wpdlSY
	 UaxdwytEU4nf++sDl3xEcaiGO01JjE2VTu3HhoK6MyOPz1UQq4eLehy/W/x6UI6J6z68J
	 pq7BfFaQsB3v/niVOs0t1FNIdI9+fT6XbdDmIc10h7yW1rAjbvCSSm7nQxyahvdzK0/Yv
	 8kYtSOv4maITplIF6ZhBk8eEPsHP3vIJOrx6xLWC8iyxth3tcyI05+bmOLLByLXw+coPl
	 pKhbVh3Acn6v5qcgSObHzcumc77PVONxnpUIxhAkQgN4xC2H4YPBJ/4wP0XF8CSAABg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795266998;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=TxW/RAptOpxLkind6FtvVROcaKbdd/cBMgMOKwStZeM=;
	b=U3NkHpsa4qmmNgUoA1YsEvU/t4ZJL/1SaCrn3ACeq3Sxoi4J6NEwaQQmEpfCRvpWT0/P
	 oBWHWR8mpxXCeZdCAUH/6H96dg6apN1nnPdKzk8JimjZJuFc8FMOHD8KBR22NaWX3egzF
	 XBHgEwViFkiY8JcalCYdNicDMOLST997JAVwLSoy0eLyfq1OMw2/Or60lj16lL+rH+u47
	 fXRiMXm4MKMjFEhWygN610iTsy08a5H2bGtw/fM3YUCbQnS4u1SKogBzaMNLDQp8DSMpT
	 zb6ObHBgkBHAWSs6/Z3IHd1apupBTIGgbsBpEA0LgF/ZJy7hSO0+IjMF1toS7S3aEgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPAShBr7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 77793606A32C;
	Sat, 21 Nov 2026 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPAShBr7
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 930CA1F000C0;
	Sat, 21 Nov 2026 13:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795266998;
	bh=TxW/RAptOpxLkind6FtvVROcaKbdd/cBMgMOKwStZeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bPAShBr7KOOGPBKH+XTeVXkgXBPFn40auFQSlE9hM8FDZmc2VPBT8Pq0gw83FDHHz
	 puDG/SloQy85d6f6pt40euCNXoB9KNLlbgkAg8nEZEwPv26NTv12dnjuIX1/hEkd7F
	 Y+v34WLQW/heaHEZxlua+xB+3xcxWtK887Hdmb/5Kj5r/xUU7kORPO2reS/uCP5scj
	 28VUcr02GlWxQzAWdy5DXSsAacKGZplfY7yTt8sxZ31jBcV/4+tI3snCWxj+0uAVEJ
	 Hbjv/Gkh1sBmM/osurXObPF/vRMcavLbYjGrfmTZo2LL7YmOjGy/E0D83NqUxvDb/r
	 +CjTnZ4TPRP7g==
Date: Sat, 21 Nov 2026 13:51:44 +0100
From: Nicolas Schier <nsc@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kbuild@vger.kernel.org, linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org, "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH] Move struct cpu_feature to a
 <linux/device-id/cpu_feature.h>
Message-ID: <awGT4AhwcFcLsW0c@levanger>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kbuild@vger.kernel.org, linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org, "kernelci.org bot" <bot@kernelci.org>
References: <20261120202712.3377691-1-nsc@kernel.org>
 <202611211941.G0rlpNpN-lkp@intel.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202611211941.G0rlpNpN-lkp@intel.com>

On Sat, Nov 21, 2026 at 08:01:20PM +0800, kernel test robot wrote:
> Hi Nicolas,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on kvm/queue]
> [also build test ERROR on kvm/next linus/master v7.4-rc3]
> [cannot apply to kvm/linux-next next-20261119]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Nicolas-Schier/Move-struct-cpu_feature-to-a-linux-device-id-cpu_feature-h/20261120-212711
> base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
> patch link:    https://lore.kernel.org/r/20261120202712.3377691-1-nsc%40kernel.org
> patch subject: [PATCH] Move struct cpu_feature to a <linux/device-id/cpu_feature.h>
> config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20261121/202611211941.G0rlpNpN-lkp@intel.com/config)
> compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 3b14d7c370558b46e5f0c6494a05c492e59bf32c)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261121/202611211941.G0rlpNpN-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202611211941.G0rlpNpN-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/s390/crypto/pkey_cca.c:22:45: error: array has incomplete element type 'struct ap_device_id'
>       22 | static struct ap_device_id pkey_cca_card_ids[] = {
>          |                                             ^
>    drivers/s390/crypto/ap_bus.h:158:9: note: forward declaration of 'struct ap_device_id'
>      158 |         struct ap_device_id *ids;
>          |                ^
>    1 error generated.
> --
> >> drivers/s390/crypto/pkey_ep11.c:23:46: error: array has incomplete element type 'struct ap_device_id'
>       23 | static struct ap_device_id pkey_ep11_card_ids[] = {
>          |                                              ^
>    drivers/s390/crypto/ap_bus.h:158:9: note: forward declaration of 'struct ap_device_id'
>      158 |         struct ap_device_id *ids;
>          |                ^
>    1 error generated.

That is fixed by [1] which is to be applied before the patch referenced
above.

[1]: https://lore.kernel.org/linux-kbuild/66e4ee9c7f9b4bc48fcee92a94b6bb6d92fe1ad2.1794233316.git.sashal@kernel.org/

-- 
Nicolas
