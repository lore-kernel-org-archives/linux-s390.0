Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388010AbgJISD7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Oct 2020 14:03:59 -0400
Date: Fri, 9 Oct 2020 20:03:49 +0200
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: Re: [PATCH 1/2] net: smc: fix missing brace warning for old
 compilers
Message-Id: <20201009200349.9bad6973760905b7d452e67a@linux.ibm.com>
In-Reply-To: <20201008121929.1270-1-shipujin.t@gmail.com>
References: <20201008121929.1270-1-shipujin.t@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Pujin Shi <shipujin.t@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Ursula Braun <ubraun@linux.ibm.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hankinsea@gmail.com

On Thu,  8 Oct 2020 20:19:28 +0800
Pujin Shi <shipujin.t@gmail.com> wrote:

> For older versions of gcc, the array = {0}; will cause warnings:
> 
> net/smc/smc_llc.c: In function 'smc_llc_send_link_delete_all':
> net/smc/smc_llc.c:1317:9: warning: missing braces around initializer [-Wmissing-braces]
>   struct smc_llc_msg_del_link delllc = {0};
>          ^
> net/smc/smc_llc.c:1317:9: warning: (near initialization for 'delllc.hd') [-Wmissing-braces]
> 
> 1 warnings generated
> 

Acked-by: Karsten Graul <kgraul@linux.ibm.com>

-- 
Karsten
