Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340F0D26D
	for <linux-s390@vger.kernel.org>; Fri, 23 Feb 2024 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682276; cv=fail; b=gNW/2u80aIfm2Ug6e36vmHKyV9tA+LD2mHsxce2c5xHYnVe10Bg3wis3c4+zg5n7yy/vjaJKtHV15qgDMZc+vh8gexZW1eYZyiuhwrfZeRkKEBBfpjgYJN6isAG38VM+6CFgXPjiZeJJQHF/rgJXq8dMgRH3DK/VuMYEsiP0OSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682276; c=relaxed/simple;
	bh=Squ8iJZc2EoQPb02c5W6NX6NajDml/xvr5MHpTmERCw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o0cHvlbVnuoiljvfJtvpHrbusvcgn3etnaKOFqcLeb3VBpCd5wzQ6MLCTQcfiDJ3XUSD8H8mgv1Ms74lOn1A3wjp1J3A0NjoRXtfeBSdRFE+Si1dpw9IJAJq1eT2AaVdahF3857mggqYBd8sqWrOkMz5JPe0iWXhhgmLXJw5zMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvGIrOfJ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvGIrOfJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708682274; x=1740218274;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Squ8iJZc2EoQPb02c5W6NX6NajDml/xvr5MHpTmERCw=;
  b=jvGIrOfJZmjtVLgD83uFneiW+mU+vGNN9giRFc+S340eXKtR8D24LnNJ
   VOh5PVjqaoar78A8nWpl87nti728wydvM4wsIvGVbyYFVdIr/MnWPlEBG
   uNfch6miy7RWY/1KllrazgcB/B8jI1Y1eZFx2culOKOn/fEX6IMcT8jMO
   qRNlMKvjYpYHdYu0g0We7/YGRT2aKpQhiZW3Zd9qhx6ygK82LpQYgehYv
   LB3cRB71k2RdXbQtnZKqt3jzCJRW1bPBIiEc5GkxFsbtQ3sL4Q5FqQsZL
   H8TtZj4aauTDvQGcWC5gaQAQ5Ozzhi3ZVGycvYVx8VDh+x5y6M6HVSgMO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="28420776"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="28420776"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 01:57:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10461645"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 01:57:53 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 01:57:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 01:57:53 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 01:57:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odaueB2RXI6J0inpdQ6jIzxHYcESpJJrtgF41ebRkxbjXjFfsM+NeRfNxz5X5nZ6ShOXyg/RISEVO0bwlMxpd1EX5vkzfRUky6a83YLcwSW+9WgnD46E0p7SpzeoRNtiAhGNnlDOYaiBlA8G0/IUezMora35UDLnWCyECZtjLUI/Ak8jRWC9Sl/efyXHDNTHSowkMdzTHmcORDHtu600eUnKxGFHW3DlWX6VkqvG3ODKZNS4okKZQfHKreiHUSOD4QZPT/guQj/tEEfJWQ8wyjXXkEzCJb2qIOwGBpL3mwNJf0DZuXUBZRocjHmiiw77+LaRiJnl76SMJJJGY/wcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQR8zQGX/+B86VokDpwU8pHct5LwMmhUxjv1xoDHPRQ=;
 b=eGvujTXW622FhwiIfIooDavpV1s6lssyGVOABQF/3J0cHza1tNobgWelMuyvo1bP7AL6llFq+AGhvG/rf/rKxipI51IeuLvxyPU2wPVz4nx2wvhDNy4sueU+FT7fYdZGyydEnSLnAHd6KYqc+ZPBqRTQE8CfCU3lCNaFCBaplyUSxOFwWMtB/eaOk1iaWaA4D540eWEVqAsM3wBCTCuhov2/m10fwOhE608ZOeNK34koKEwnwbytg73yh9eD4jFIHhtgCOv+KUjSIxJ1COVJQewQnHI04NUz6av4nbBLdFka21Uoiz5mO63oxOczKJbduHxog+GEXcLt/Ncq6FQ3MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CY5PR11MB6090.namprd11.prod.outlook.com (2603:10b6:930:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 09:57:51 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca%5]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 09:57:51 +0000
Date: Fri, 23 Feb 2024 17:50:57 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, "Sumanth
 Korikkar" <sumanthk@linux.ibm.com>
Subject: Re: [s390:features 97/98] Unsupported relocation type: 21
Message-ID: <ZdhqgYQizQDR+qEa@yujie-X299>
References: <202402221404.T2TGs8El-lkp@intel.com>
 <20240222173727.f74r4wjolrbmnm6u@treble>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240222173727.f74r4wjolrbmnm6u@treble>
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CY5PR11MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b6c95b-e1b1-4384-2810-08dc3455e5cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBqtKeXyFYLDDEnqfNgg+0tvrRPRipyA6dl1YsmYn0U4K6yUkY/pY1/cPg+Zd4BpmwRAnuBV5EWOGqbcMfuMjzA1gfgBDgaqglHtr4Nu+ezCQSP8xQJYrFQBcoGqb4fDqIW5eTxD/tBc6Oo1k+GDc9EZCMKiX0c3ZQDAEv6QGClyi2/DQZ2nIu7/y4m6nyjSHcQFHRKyZbaMj5IH5MlfSBk22WJ1avUlkl7/xuL1jqaNAFP6Fo+GmCkCwIgFoyuBJuQvlO9Y/b0k9d8FBleXRyPpU/iM6ud3vD/odWbZBHnQoRSiaL0/VsIsmAO4oNTkGl2nIq3UT4qXE/fjBXJ8zbKinuHRHgdxIl6oAfulEWy9MZfT2h5fh3REhdCjiMnZ7EAyvVR7wVvnqna3td+NMp7wLlQb7M1NJ/KfwoxQiyNruxfXLpdc0x8kltrS68NMCGS3Egjivsss012s7IW42lJ3uheqGY67o2M/rrImk8qa9ZXkDi/12KFNeG0BnmHgnXO710Gnduc5Hv4J/5/+zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nsqcTErpInpXPPU5DScYmjHnfuPIsFP1YrtbFdpkvhIFByZ0NZbsB72GZONG?=
 =?us-ascii?Q?PjBFqgvLjBGCV7+oyukZZExditZuB9HIR4MXlEZ9vs9HYnaPW25LjDZnZi5t?=
 =?us-ascii?Q?eHOO36XKhBirsLvk8KhqHp1ehfOzyqibHbdhwAKfSauPFUwp+wRYIpVQDqSn?=
 =?us-ascii?Q?KM8NQbl1Fe+pwIvmcmJ4RFSiY70bPqdesZinUQgus4K5R1/zv0mM+2fv+1on?=
 =?us-ascii?Q?wzHCBcrGIKaIj1IT653lvDRWLXbHgp/Sxiqk7p6R2q6JAabL3rpYjaHo5JE+?=
 =?us-ascii?Q?4oUMEIgkFxjfDnEQsAyTpBEON9yGgpxgrQJq2XvWTMgDbgo0+zGo3BItmahM?=
 =?us-ascii?Q?FI7zugmbGwKqW5FjneJ2Suzoh8+/ai+KyVLTN9wA4jSsV+3kDwRjXrcZAH+c?=
 =?us-ascii?Q?uCNxp/ee7crPHguND5Dc/tzajC1zaH9mvCpHTFCgBQ0ejOcctQLfELcPhyFY?=
 =?us-ascii?Q?yut9fbTezBBrlMj+du27PEsp4rQwqT2Z6EsSX0KaBYOTVrkbqclDP/QWu6ZM?=
 =?us-ascii?Q?0ec5B+8sObezo3Oe2lX7yezjS0nT3qBcUaXHh/yVyT5d806wOraUhSpbvT1Q?=
 =?us-ascii?Q?MTUoxjEI5tGV+G4dO8RZohxGUBsDn6Pn1ov6/FtBj4vblFqNlabYqMhU5jif?=
 =?us-ascii?Q?FZaxwTBf8uefo0QLrKGoVSOHJJexh+jP3Cn2lYdcUPLsyIkVp9dsURbK7TiL?=
 =?us-ascii?Q?y9qseJtjZARf78BErdU7zpdaxvgKmxUgvNMRb8jA+YS9MkUvZSWXBM2DTrW2?=
 =?us-ascii?Q?KehEhdJ3nJh+YDaTI+jXoc2GayngwxOpdVISekrbrPfayJdsd3UUTGVWGGc8?=
 =?us-ascii?Q?KPti7kyeSq1N2qmCA+IAMZ7Ig4txPtNXr6Kq/umLFNK/pfq3nZRcRzjsqK4Z?=
 =?us-ascii?Q?RhcQx1MvQLWl90OkzyF78y8KeE7HrhUF9sH6x7sE157BLxveE9oI50lKrLwI?=
 =?us-ascii?Q?WKjs+aLXAq0JGLibB/y3un200So3A2L7lAMAalb7kDmCefBLVBDWbGGKqha7?=
 =?us-ascii?Q?r0ryAg2Z8MXsGrbdppUU07p6EsrLIreQvJx0YCK3qrZL6o5Ms6Kkr0W4a0u1?=
 =?us-ascii?Q?ctStPwOh7AzIRMZd1+aXrhWu5Mp7Uz6vOoDKppJVc2abf1GoSh1t9izSLJ2E?=
 =?us-ascii?Q?S6/mwJFEcTwe154ZLB+En4QAfRPHCyoOQeu/MfPmxDcrlNb/dPHxA2Dkuvky?=
 =?us-ascii?Q?E5xEX3G6aFBQ70TfFTbdwEd2xdzSnlvq/KfjIwpWovmCQR/LBOPhiojS2SpQ?=
 =?us-ascii?Q?okc4MzU2uTlWOqS174l+ZwqGU81fLgv6TfkzjJzpz/2SQ9DD7yDxozOXDOkF?=
 =?us-ascii?Q?87BSKP57+YTMhyay90cyXY2CFU850X4H7saU4UB5LwGiqaSldK+dYj+qracL?=
 =?us-ascii?Q?/So8zDjotNMdsyz0W3qdrvOExnyLqxKZX4BdZR1WKuv9AN35mSd0YEmaIDPr?=
 =?us-ascii?Q?pO3JXDbfaCOraH36FA3skKQGD8tlecUF0haEALfrlNW0KJps3u6tfY0aBYgf?=
 =?us-ascii?Q?W76YHzUCBaevOX3JQMUpviXE4em+kev7FRKZMLp/eWXmv1i+FGoojkpcb3mw?=
 =?us-ascii?Q?csZt9cklDFBL/s/TmGoyKdzYA3zFgfutzlSR69eN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b6c95b-e1b1-4384-2810-08dc3455e5cf
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 09:57:51.3310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IH4yFH+ltJWliVl5FIRn6HBdQCPBqXUz4CVKqBuSkAmEKilYH1eb9AZsp1m9BY6dNpe87cBmPC8DE97NAnFz6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6090
X-OriginatorOrg: intel.com

Hi Josh,

On Thu, Feb 22, 2024 at 09:37:27AM -0800, Josh Poimboeuf wrote:
> On Thu, Feb 22, 2024 at 02:42:01PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
> > head:   4a5993287467d2d0401503256dc9d2690c7f2020
> > commit: 778666df60f0d96f215e33e27448de47a2207fb3 [97/98] s390: compile relocatable kernel without -fPIE
> > config: s390-randconfig-002-20231016 (https://download.01.org/0day-ci/archive/20240222/202402221404.T2TGs8El-lkp@intel.com/config)
> > compiler: s390-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240222/202402221404.T2TGs8El-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202402221404.T2TGs8El-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> Unsupported relocation type: 21
> 
> This is R_390_GOTPCDBL, which I believe can be ignored by the relocs
> tool since it's related to the GOT.
> 
> I'm not able to recreate with my s390 toolchain (12.2.0), but I suspect
> the following fixes it:
> 
> diff --git a/arch/s390/tools/relocs.c b/arch/s390/tools/relocs.c
> index db8bcbf9d8f8..ad3773dc1f95 100644
> --- a/arch/s390/tools/relocs.c
> +++ b/arch/s390/tools/relocs.c
> @@ -276,6 +276,7 @@ static int do_reloc(struct section *sec, Elf_Rel *rel)
>  	case R_390_PC32DBL:
>  	case R_390_PLT32DBL:
>  	case R_390_GOTENT:
> +	case R_390_GOTPCDBL:
>  		break;
>  	case R_390_64:
>  		add_reloc(&relocs64, offset);
> 

We tested the diff above. The "Unsupported relocation type: 21" error
goes away but another "Unsupported relocation type: 28" error appears.
Refer to arch/s390/include/asm/elf.h, seems R_390_GOTOFF64 also needs to
be taken care of.

The original error is as below, which can be reproduced by both gcc-12
and gcc-13 in our tests:

$ wget https://download.01.org/0day-ci/archive/20240222/202402221404.T2TGs8El-lkp@intel.com/config -O .config

$ s390-linux-gcc --version
s390-linux-gcc (GCC) 13.2.0
$ make ARCH=s390 CROSS_COMPILE=s390-linux- olddefconfig
$ make -j72 ARCH=s390 CROSS_COMPILE=s390-linux-
...
  RELOCS arch/s390/boot/relocs.S
Unsupported relocation type: 21
make[2]: *** [arch/s390/boot/Makefile:118: arch/s390/boot/relocs.S] Error 1
make[2]: *** Deleting file 'arch/s390/boot/relocs.S'
make[1]: *** [arch/s390/Makefile:142: bzImage] Error 2

After adding "case R_390_GOTPCDBL:":

$ make -j72 ARCH=s390 CROSS_COMPILE=s390-linux-
...
  RELOCS arch/s390/boot/relocs.S
Unsupported relocation type: 28
make[2]: *** [arch/s390/boot/Makefile:118: arch/s390/boot/relocs.S] Error 1
make[2]: *** Deleting file 'arch/s390/boot/relocs.S'

Not sure if R_390_GOTOFF64 can also be ignored as R_390_GOTPCDBL. We
tried this and the bzImage is successfully built:

$ make -j72 ARCH=s390 CROSS_COMPILE=s390-linux-
  HOSTCC  arch/s390/tools/relocs
  CALL    scripts/checksyscalls.sh
  RELOCS arch/s390/boot/relocs.S
  AS      arch/s390/boot/relocs.o
  LD      arch/s390/boot/vmlinux.syms
  DUMPSYMS arch/s390/boot/vmlinux.syms
  OBJCOPY arch/s390/boot/syms.o
  LD      arch/s390/boot/vmlinux
  SECTCMP .boot.data
  SECTCMP .boot.preserved.data
  OBJCOPY arch/s390/boot/bzImage

This is a randconfig build test, and issue can be fixed by ignoring both
R_390_GOTPCDBL and R_390_GOTOFF64, but not sure if this is a complete
fix for build tests on all kinds of configs.

Seems there are several other GOT related constants defined in
arch/s390/include/asm/elf.h. Could you help check if there may be
other ones to be handled together?

Thanks,
Yujie
