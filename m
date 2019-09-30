Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34791 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730833AbfI3LW0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Sep 2019 07:22:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id q203so7398942qke.1
        for <linux-s390@vger.kernel.org>; Mon, 30 Sep 2019 04:22:25 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_alloc: fix a crash in free_pages_prepare()
Date: Mon, 30 Sep 2019 07:22:23 -0400
Message-Id: <A5AEF8D5-C44F-406C-BCAA-79F32AA41219@lca.pw>
References: <20190930110434.5k47w7xfvkjcohkp@box>
In-Reply-To: <20190930110434.5k47w7xfvkjcohkp@box>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org



> On Sep 30, 2019, at 7:04 AM, Kirill A. Shutemov <kirill@shutemov.name> wro=
te:
>=20
> Looks like Power also uses the hook. Have you check that this patch will
> not affect Power?

Yes, I did. Although I did only test radix memory which seems just return im=
mediately in arch_free_page(), I code-review the non-radix memory path and d=
id not find anything suspicious. However, if really needed, I could test has=
h memory config or adding powerpc developers to double-check.=
