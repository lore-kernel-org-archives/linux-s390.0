Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE1CC433F5
	for <linux-s390@archiver.kernel.org>; Wed,  5 Oct 2022 11:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiJELvj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Oct 2022 07:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiJELvM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Oct 2022 07:51:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9822B7B798
        for <linux-s390@vger.kernel.org>; Wed,  5 Oct 2022 04:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664970547; x=1696506547;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0Y8MK7tan8S3Cy8Ycj+6gK8/gdvOHOygIpztM55T5Ew=;
  b=Z7hIaWZHwUvOaNyIZbp+q8lZnv96clfBiF3l4GZkj+RA93CnFx+oPxwo
   h0IawYL1ABzqo92lzE2FM1ZEixp89dfc7vV5BjmqJeuc9m+97N76AkpnM
   vDfEuYtRW6rE6H5fqhEJtjKReB8a+uIGHqxT7HDu/GoOka2BqNC4YNlij
   5ejpt/p4tKQlFq43rY+E7wuRapJ5xY6OuJms9Kj4QEmXFYXthToeOHCl8
   atS/3AfC38TF2XYkRoI8L0a5LnQs37FI6AcAsQFxwI9+JhxF/7DeUwi2P
   oaZRC+cNUYlumLd9AGfMyYhXnoCKU6+U61dQU+TZZyguCGxccgTTwnRkK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="303116078"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="303116078"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 04:49:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="692858577"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="692858577"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 05 Oct 2022 04:49:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 04:49:06 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 04:49:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 5 Oct 2022 04:49:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 5 Oct 2022 04:48:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajUm9i7TnnaPqWGn92HkkarO84Lil79AqyZxindm/UNwEwMppuAeD3FdpecngguKudKoQsFhrThH10gD8flikY1W+skc/dvJTGTprkHi55tv5OXi5KNEo8sCMEQxqmxfDLv/xIZLRaxYM6WskS2E2mLphbYrCugFO8t1eyYN9zdwH52iy7Kh52kTN4Bfj0mLYb9WLFJwKh4+ysHbyW3G/L15Zz0EK44Be1Gg5w3xnbeYJDtu1TU5lZpqiaXriHEkPEfK4X3RQATKZpVo8IUlaDe6cVilmqYHNWVEKeoerzCSnwuYNp9ms80qfQpEM88EOGzfBrNa3HrVEQQxFyxiMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fiTMvqxNDyfiKgxleYP/mzhbdGGJ068zAx9oo8cWh8=;
 b=nP7g8WCIneQ0BcQTvz3oDcOFH53lflKaHe8gptD7WmoiOhTWm2nJh1/qx6QDBaqZgm1PxzBF0v+alzDTO7l75graSK/fL9cRSgVwKtKkT41kLsNzgDXU75X8WXZfT+GX7d4UaKMb/mPe4AwU5B+/9ODM0lS9wL3Y9ooZTKiUGU2qi6TrVkPXhPMF8r1bMHd7HrB7MR102X+32r+bwTDNs0ABcEBACbMRzEn68p4Fw1RpfDlVip9kS2E20PD9a9wNhhFLETbB7sTnNwHeO5yCiIM458PndGTTE/wcEFPeYyDqToX6rT+Ne1pH3WugqoaPSB6nvpQKaI+Z1icVOxpYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SA2PR11MB4873.namprd11.prod.outlook.com (2603:10b6:806:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 11:48:34 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::5482:e4d0:c7d9:e8be]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::5482:e4d0:c7d9:e8be%4]) with mapi id 15.20.5676.032; Wed, 5 Oct 2022
 11:48:34 +0000
Date:   Wed, 5 Oct 2022 19:48:22 +0800
From:   Philip Li <philip.li@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
CC:     Yury Norov <yury.norov@gmail.com>,
        kernel test robot <lkp@intel.com>, <llvm@lists.linux.dev>,
        <kbuild-all@lists.01.org>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        <linux-s390@vger.kernel.org>
Subject: Re: [kbuild-all] Re: [linux-next:master 7287/11993] s390x-linux-ld:
 topology.c:undefined reference to `__tsan_memcpy'
Message-ID: <Yz1vBgxomxKB/Frl@rli9-MOBL1.ccr.corp.intel.com>
References: <202210010718.2kaVANGb-lkp@intel.com>
 <YzeW3yqxvkpYKCxa@yury-laptop>
 <YzsMHqG9LvMZXTz8@dev-arch.thelio-3990X>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YzsMHqG9LvMZXTz8@dev-arch.thelio-3990X>
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SA2PR11MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 180a4a8d-b72f-4b67-1336-08daa6c787f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KAIKHiQqy0X/nvDSxwnJvoa7gm7S5m42rZgcicgAfc8FTAapSe4nutIvch9st0iR+so7tzm8vhfauth94ehoY6bemnujjAKtIAjWCqhOgUSS9aenHQa87gX5DkiX+YhWsyK3eRNJOc5QCACAOJG2H5d/4ZxBBHQVjNjNimIE+YwDCWgXNg6BB+9KJ/jQlCpGjPPNK6R53NEVJelV+AFpdal47ZEtCLaB9UHd7/BMyyzK+t4paQOZHcM+A+l6LCZHgFfWUeHd0xQ5zPn1JNXEBRJO/2RKCJ0LmtNFkjCeatXaUfipMtfLiqLHx3ilB/L4bVugNpXvkrwapjOCSchEkWjRq8gFag2jUL4dpClaHe/WQ6swBrIaAi+7A3Lh1znGtjPmq8QCC8jh7R8sl0lXAh0aa2XlJlZtaVI2ni7fAZFL8OHRIfTdGndAHlyeTnsHr9a8t4Z+ytm63eU9G1xjlBxVykZUNaJaMEmyiCqZWuA0GcnOCUz85PQA4qTiN/SS/LwJA4rcwTNYFTb8J5PW1cunm52Pr7AntVanuXzExEt5mk3p71eYBOeWtcQS79hh36POxPydUqTu22y3SKPDfcz5+/HOgv5VafQSplvzrTQ4K7GDMKbnuySSVlY8G29tSM4fRGXl1gST48cRinUcRw70qFFoHQgI2eFcYsIB1J/9FgOYJQJv/QZH3a9mco8V58c1HOY0ANyHhz6JWCsRlJHEt8KID12cfACp/ABCKTKXnBs/4ALQjmTKHwYQ34c6uEL0QbzMukf/FoRmXaLIRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199015)(186003)(83380400001)(38100700002)(86362001)(82960400001)(41300700001)(8936002)(5660300002)(7416002)(44832011)(316002)(6916009)(8676002)(66556008)(4326008)(54906003)(66476007)(66946007)(26005)(6512007)(6666004)(6506007)(6486002)(2906002)(966005)(478600001)(66899015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?48DWMu0PtYzZfOk9HRxvB/+4Kh8R85GiNIbAFJTx1QBrcgPfa4ogNfQrR0qU?=
 =?us-ascii?Q?kgrs3UGRO4tW09D+yNM+JurfeBiqaQ5guEylWSRY3qqpybPq7ucCYLHwi2xP?=
 =?us-ascii?Q?ghJRoPB1E4QvX1d/aNk3HWHvh2rwTCzECCF5Hc5aAv+hBYvzh4Towue7Zmrt?=
 =?us-ascii?Q?gO9LaRlV0NwlazV20fLJjeolIPFZQ4E4eglmnhki814dyp9BB8N7SvyneSXQ?=
 =?us-ascii?Q?TIGG/2VPZcacThXVZJ+LvGMVBr5t8RzoVmH69xGJnxqpzb7UrHELUfEGqf5g?=
 =?us-ascii?Q?O7LOxHC30gip5W/JNd+MtgH5F20rT2YAL5t/lrLkmo28piGURi3aqE90chcF?=
 =?us-ascii?Q?2P7srcLE/iI4FrAVGkhNaCCYHoyrH1DJqRtgyQ6srGZ9YTreHCS8aZd00w10?=
 =?us-ascii?Q?Aycqlr8YmXfgETKWfQRLRMuFVjf3Ji+SnheubFLcmE0YvirHZ8vSgRlhQkTi?=
 =?us-ascii?Q?9iS3DjwRHe46O3ia8JwnfD8zBt8qdgCBjkXo0bMogaqvdZ77cnr8gQfLfaHD?=
 =?us-ascii?Q?5Mb7+FTzbMf4T36PSQX3B3F0n155OVrotJZDPJks/MLKDBvyDIyXoU41HZUt?=
 =?us-ascii?Q?MAFSgdtQuZT+uoXbomTmQU6CNfHrNp3FtLeFOTX+H+Lun/tvMFMdlZYsI9jU?=
 =?us-ascii?Q?ngh8YMFC8EGHGsywVg2pb3SPw9f9R8q7FqzPKv4737qeCn5fVAN9G5tQvXGa?=
 =?us-ascii?Q?xLh5Dqb2Bf+tbXP6+Frci7jxwZ9VDK66MWjb2Asps+WXEG78k6nk7WiwMGut?=
 =?us-ascii?Q?KwU/3pw/y2s+flB4pyoEabm9tjaOg7JSAvucd/LNgOBHTsuD7E7E/Q4UP5KD?=
 =?us-ascii?Q?1KJbXiM9FmYk2NUNMvp3tTMgNKaSVb8ZsoNNiVqs8xInfARcUfjTxOGFQAQ/?=
 =?us-ascii?Q?AobJwavTFUda/rVQ84dEaetP6If5of8NLRHku5TCv9zWKp+068NnOGWpU09i?=
 =?us-ascii?Q?JyHvXlu7FRHvIlHUpXiszmEkNGfEkSYVeLFV00nk4+cm5ChFWaaMF/EwaWUt?=
 =?us-ascii?Q?QlVNIOwVStB/C7dQYKXHMKsBEjUKfk29eeaAei5oni+CcR635I2gIFpKrbx+?=
 =?us-ascii?Q?fmoSFuJVEkdtBUG6MnwxBFrM788scOg2elEampZrAcWM4B1gA9mUSVEHjB30?=
 =?us-ascii?Q?Go3mrrlbSyQrFJ1g2uXPjddeRn+4dFhySXq2lnZjPZCh+6Xz83d9c87Qste7?=
 =?us-ascii?Q?yo2O9p9cIC84FPIc0S/RLUVINqFzMq+K0Ym8neXh7jpeem8QU75rDonS9w3B?=
 =?us-ascii?Q?kxleeBBhbR6HBz2MgDlJFSsusKsXtwJkMbXXWaQE5LYIaE/17FDUWKf05aRB?=
 =?us-ascii?Q?oDOyO+fTxSvL+D5fi4sxs1G513NSuwQnYp9h5lqinNa5g5pPfNzjpnZPoOsA?=
 =?us-ascii?Q?I9xutiUzrw0i2W0i5t8BBBDHE+hrfnGBufAoQPTL54xDRWL9N9cwMLocXqla?=
 =?us-ascii?Q?nqalqOLPqKL/hvsw6bg/15MRcunxlm4/A9Zhne7SOrUPdJDBjb+1/qfdO9Du?=
 =?us-ascii?Q?d8WlE2U4L9fZlJM2WquZMpcGiR/vboh65iB0rpQo/8fpkQe3u3Wcm+57jfPp?=
 =?us-ascii?Q?yehUXnhk0l6NumBFo75c0v0TJOOuybXVCTHRKWnE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 180a4a8d-b72f-4b67-1336-08daa6c787f0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 11:48:33.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0WoR6TFJKkrsntwE6oSh9r9q01RDEwOV7HcaCClx9ZAxYZE6wCc7Za67HGJRMWPbayJo6Yf1VthHsAAIWqWVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 03, 2022 at 09:21:50AM -0700, Nathan Chancellor wrote:
> Hi Yury,
> 
> On Fri, Sep 30, 2022 at 06:24:47PM -0700, Yury Norov wrote:
> > On Sat, Oct 01, 2022 at 07:12:48AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > > head:   274d7803837da78dfc911bcda0d593412676fc20
> > > commit: aa47a7c215e79a2ade6916f163c5a17b561bce4f [7287/11993] lib/cpumask: deprecate nr_cpumask_bits
> > > config: s390-randconfig-r023-20220926
> > > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install s390 cross compiling tool for clang build
> > >         # apt-get install binutils-s390x-linux-gnu
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=aa47a7c215e79a2ade6916f163c5a17b561bce4f
> > >         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > >         git fetch --no-tags linux-next master
> > >         git checkout aa47a7c215e79a2ade6916f163c5a17b561bce4f
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    s390x-linux-ld: ipl.c:(.text+0x1004): undefined reference to `__tsan_memcpy'
> > >    s390x-linux-ld: ipl.c:(.text+0x1046): undefined reference to `__tsan_memset'
> > >    s390x-linux-ld: arch/s390/kernel/ipl.o: in function `reipl_fcp_scpdata_write':
> > 
> > I can't reproduce the bug. In fact, the build is broken for me on
> > next-20220930. To make the s390 image somehow building, I commented
> > out some functions that aren't found by the LD.
> 
> Sorry for the noise, this is not a kernel issue, it is a toolchain
> problem that will be fixed soon:
> 
> https://github.com/ClangBuiltLinux/linux/issues/1704
> https://lore.kernel.org/20220912094541.929856-1-elver@google.com/
> 
> I had asked the Intel folks to stop sending reports based on this build
> breakage a few times but it seems like their filter is not working
> still?

Sorry for this, we will correct the filter logic asap, it only ignores
__tsan_memset now, which should be mem* as mentioned in the link.

> 
> https://lore.kernel.org/Yx3HnuEDyFG0+G62@dev-arch.thelio-3990X/
> https://lore.kernel.org/Yy3PxL973jtEtEUK@dev-arch.thelio-3990X/
> 
> Cheers,
> Nathan
> 
> > Thanks,
> > Yury
> > 
> > diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
> > index 886de028a901..d696d78132a0 100644
> > --- a/drivers/irqchip/irq-al-fic.c
> > +++ b/drivers/irqchip/irq-al-fic.c
> > @@ -235,6 +235,7 @@ static struct al_fic *al_fic_wire_init(struct device_node *node,
> >         return ERR_PTR(ret);
> >  }
> > 
> > +void __iomem *of_iomap(struct device_node *np, int index);
> >  static int __init al_fic_init_dt(struct device_node *node,
> >                                  struct device_node *parent)
> >  {
> > @@ -249,7 +250,7 @@ static int __init al_fic_init_dt(struct device_node *node,
> >                 return -EINVAL;
> >         }
> > 
> > -       base = of_iomap(node, 0);
> > +       base = NULL;//of_iomap(node, 0);
> >         if (!base) {
> >                 pr_err("%s: fail to map memory\n", node->name);
> >                 return -ENOMEM;
> > diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
> > index 7633b227b2ca..4e4c9d9743bf 100644
> > --- a/drivers/net/ethernet/altera/altera_tse_main.c
> > +++ b/drivers/net/ethernet/altera/altera_tse_main.c
> > @@ -1122,8 +1122,8 @@ static int request_and_map(struct platform_device *pdev, const char *name,
> >                 return -EBUSY;
> >         }
> > 
> > -       *ptr = devm_ioremap(device, region->start,
> > -                                   resource_size(region));
> > +       *ptr = NULL;//devm_ioremap(device, region->start,
> > +               //                  resource_size(region));
> >         if (*ptr == NULL) {
> >                 dev_err(device, "ioremap of %s failed!", name);
> >                 return -ENOMEM;
> > diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> > index 230c2d19116d..9f88be3c2b08 100644
> > --- a/fs/afs/dir.c
> > +++ b/fs/afs/dir.c
> > @@ -49,6 +49,7 @@ static bool afs_dir_dirty_folio(struct address_space *mapping,
> >                 struct folio *folio)
> >  {
> >         BUG(); /* This should never happen. */
> > +       return false;
> >  }
> > 
> >  const struct file_operations afs_dir_file_operations = {
> > 
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
