Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728076AbgEEUKE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 16:10:04 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25989C061A0F
        for <linux-s390@vger.kernel.org>; Tue,  5 May 2020 13:10:04 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 72so32989otu.1
        for <linux-s390@vger.kernel.org>; Tue, 05 May 2020 13:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200505162559.14138-1-jwi@linux.ibm.com> <20200505162559.14138-11-jwi@linux.ibm.com>
 <20200505102149.1fd5b9ba@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <a19ccf27-2280-036c-057f-8e6d2319bb28@linux.ibm.com> <20200505112940.6fe70918@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <6788c6f1-52cb-c421-7251-500a391bb48b@linux.ibm.com>
In-Reply-To: <6788c6f1-52cb-c421-7251-500a391bb48b@linux.ibm.com>
From: Edwin Peer <edwin.peer@broadcom.com>
Date: Tue, 5 May 2020 13:09:27 -0700
Message-ID: <CAKOOJTzfbo9NJpOWpNn5B-oQ_yTvc7-ZxJP6dWvCV46p0z-T3A@mail.gmail.com>
Subject: Re: [PATCH net-next 10/11] s390/qeth: allow reset via ethtool
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>

On Tue, May 5, 2020 at 12:57 PM Julian Wiedmann <jwi@linux.ibm.com> wrote:

> It's a virtual device, _none_ of them make much sense?!

Why not introduce a new reset bit that captures the semantics of
whatever qeth_schedule_recovery does?

Regards,
Edwin Peer
