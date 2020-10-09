Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4988 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731771AbgJISES (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Oct 2020 14:04:18 -0400
Date: Fri, 9 Oct 2020 20:04:08 +0200
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: Re: [PATCH 2/2] net: smc: fix missing brace warning for old
 compilers
Message-Id: <20201009200408.35d9575b2813afb57015ec7e@linux.ibm.com>
In-Reply-To: <20201008121929.1270-2-shipujin.t@gmail.com>
References: <20201008121929.1270-1-shipujin.t@gmail.com>
        <20201008121929.1270-2-shipujin.t@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Pujin Shi <shipujin.t@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Ursula Braun <ubraun@linux.ibm.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hankinsea@gmail.com

On Thu,  8 Oct 2020 20:19:29 +0800
Pujin Shi <shipujin.t@gmail.com> wrote:

> For older versions of gcc, the array = {0}; will cause warnings:
> 
> net/smc/smc_llc.c: In function 'smc_llc_add_link_local':
> net/smc/smc_llc.c:1212:9: warning: missing braces around initializer [-Wmissing-braces]
>   struct smc_llc_msg_add_link add_llc = {0};
>          ^
> net/smc/smc_llc.c:1212:9: warning: (near initialization for 'add_llc.hd') [-Wmissing-braces]
> net/smc/smc_llc.c: In function 'smc_llc_srv_delete_link_local':
> net/smc/smc_llc.c:1245:9: warning: missing braces around initializer [-Wmissing-braces]
>   struct smc_llc_msg_del_link del_llc = {0};
>          ^
> net/smc/smc_llc.c:1245:9: warning: (near initialization for 'del_llc.hd') [-Wmissing-braces]
> 
> 2 warnings generated
> 

Acked-by: Karsten Graul <kgraul@linux.ibm.com>

-- 
Karsten
