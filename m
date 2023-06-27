Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAA5EB64DC
	for <linux-s390@archiver.kernel.org>; Tue, 27 Jun 2023 02:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjF0Czf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Jun 2023 22:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjF0Czd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 26 Jun 2023 22:55:33 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CBD19A8
        for <linux-s390@vger.kernel.org>; Mon, 26 Jun 2023 19:55:31 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-401d1d967beso136321cf.0
        for <linux-s390@vger.kernel.org>; Mon, 26 Jun 2023 19:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687834530; x=1690426530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6m+wEFcEkBY8kPY3Kx1wllLpYaRIsGxbOUyAAHvddU=;
        b=ExOjo+32OkxgczlDHvAA93Sbizsv21cvgNnqKyveTvbuoZMVxqcmZEgPgSllcehguu
         dbX+ENH+6Ay2FKPsfQQPRgwk9gig7UN/Bqn5dy0/3Lt52aEGpC6a0CWZuDlLqxGVuynQ
         ePD+CMarbkoMLKhi58XFMsuv2TxpZMqD4UY8o5PNiJT66wQAkDvlNiFFn0BYTqgMvXPt
         9NcqlCm40PM9effdAviY9KeE8HRGVu4E/rigBJg7RATr+OyC7hI4fz3nHHxtdPodsK9Y
         PNjY12fUxpUwZPWspB5JgiUTyLdHqVtoy8OZEW6quF96sK7Xy1kFz342QD8ZJJbxbPpN
         +zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687834530; x=1690426530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6m+wEFcEkBY8kPY3Kx1wllLpYaRIsGxbOUyAAHvddU=;
        b=kidSeWV9hZ0/h3Ea5HnFNs8jQxTPsWQuYEzdyj6twvi1iBRXkCjEue2JPt54QpgqKX
         3veO1HRZWkKK/dmXMLXd4JD8eHmlEz8EeId6MbIIoyHPfn2ZrfxgaZhxZJdUb9ugN1zF
         iV2SQsqgy9tpsciX0t2itL9fqMzf6KzXi1zopuY6T2DgoRVQQqcxTtFEPFDj9fWke3X+
         YySMOeK5PYUwgaDWWaNyH2auwRS0LM8CxTeTLHkmwoJOrlyKnWK7qK+h5KVO5SNhGwdc
         UEH8MOn93xlXGhUMDmDfUaRQW/5M1ScILi2sDADzf2X+w0WS8vPedVN/HFi304Fw6Dnr
         bbig==
X-Gm-Message-State: AC+VfDwPkG4Z8s6q2mMs80TtXQCFImkU7b78TUXR3WO30r7Xb531b4N2
        dlg4bffntatUX6AZPu+r3D01Nnghn02QkYffyWlIAw==
X-Google-Smtp-Source: ACHHUZ4HHpDDlpCkNylVwPD6Vtl3Tw7Wkd/6GWnr7BTs/XNVIfH6MktIHos0KxldS43iWx3GtWhQNV7SWLRv/Puj8+4=
X-Received: by 2002:a05:622a:d1:b0:3f0:af20:1a37 with SMTP id
 p17-20020a05622a00d100b003f0af201a37mr70012qtw.15.1687834530512; Mon, 26 Jun
 2023 19:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com> <20230626171430.3167004-7-ryan.roberts@arm.com>
In-Reply-To: <20230626171430.3167004-7-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 26 Jun 2023 20:54:54 -0600
Message-ID: <CAOUHufYBSc=RKpPg4PuHduJiWKOe+vpA_rZVo-9-gFvVue0huQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/10] mm: Allow deferred splitting of arbitrary large
 anon folios
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 26, 2023 at 11:15=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> With the introduction of large folios for anonymous memory, we would
> like to be able to split them when they have unmapped subpages, in order
> to free those unused pages under memory pressure. So remove the
> artificial requirement that the large folio needed to be at least
> PMD-sized.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Yu Zhao <yuzhao@google.com>
