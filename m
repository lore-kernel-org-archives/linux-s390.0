Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8225C432BE
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 02:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B92A60FE8
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 02:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbhHaCUX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 30 Aug 2021 22:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239546AbhHaCUW (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Aug 2021 22:20:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FE13601FD;
        Tue, 31 Aug 2021 02:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630376368;
        bh=VTRc4vv8EkgtSGV1wWLNzhTaOzg126Vm7jyCEGgW258=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VE/AXwjI9cecjCBl276Ldf9LtZZbLv6ZGM3R70TEZc8J9IL1GMFNV461ZeFbd2efS
         /SJK1lQfzOirAXPVY+Wvycy2MtXYYLEcu48G6KNg7KWQo75mAjEUsMususRamVYY/G
         ikxwuDTXxDP34gpq7gVEJfL017pMSY4dhgKAOy4/qLIvsYX1VQBEy+rKEuzJR0lZV4
         OMjNgEEMyr2SukYpf0bbO4G1OuuUZyJS024Zb6CSG7VUgGaI/nplbS9hL46Fel8FDe
         nAazXW5AZwA02smQ5lfk2GgeekdVfvBJkk5NtYuvQm7GxMOqISA4g7KvOAM3lLzyzV
         q4Ibfsmcxhj+Q==
Date:   Mon, 30 Aug 2021 19:19:25 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [GIT PULL] s390 updates for 5.15 merge window
Message-ID: <YS2RrUma2oOSYtIc@Ryzen-9-3900X.localdomain>
References: <YSzZFgBt6nMvpVgc@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSzZFgBt6nMvpVgc@osiris>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Heiko,

On Mon, Aug 30, 2021 at 03:11:50PM +0200, Heiko Carstens wrote:
> - Enable KCSAN for s390. This comes with a small common code change to fix a
>   compile warning. Acked by Marco Elver:
>   https://lore.kernel.org/r/20210729142811.1309391-1-hca@linux.ibm.com/

This caught my eye, as we are boot testing KCSAN + KCSAN_KUNIT_TEST in
our CI [1] for x86_64 so it would be nice to enable this for s390 as
well. However, it does not seem like the unit tests pass when booting up
in QEMU, is this expected or am I doing something wrong? The results and
compiler versions are below (the results are the same), they should both
have the commits that are mentioned in the KCSAN message.

GCC 12.0.0 @ d904008df267cbcc01bd6edf98fa0789fb6e94da

[  131.813482]     not ok 1 - test_basic
[  135.321137]     not ok 2 - test_concurrent_races
[  138.830648]     ok 3 - test_novalue_change
[  142.342562]     not ok 4 - test_novalue_change_exception
[  145.851008]     not ok 5 - test_unknown_origin
[  149.361416]     ok 6 - test_write_write_assume_atomic
[  152.872013]     not ok 7 - test_write_write_struct
[  156.382960]     not ok 8 - test_write_write_struct_part
[  159.890222]     ok 9 - test_read_atomic_write_atomic
[  163.402919]     not ok 10 - test_read_plain_atomic_write
[  166.912931]     not ok 11 - test_read_plain_atomic_rmw
[  170.431915]     not ok 12 - test_zero_size_access
[  173.940959]     ok 13 - test_data_race
[  177.452028]     not ok 14 - test_assert_exclusive_writer
[  180.962840]     not ok 15 - test_assert_exclusive_access
[  184.474686]     not ok 16 - test_assert_exclusive_access_writer
[  187.992282]     not ok 17 - test_assert_exclusive_bits_change
[  191.501869]     ok 18 - test_assert_exclusive_bits_nochange
[  195.013138]     not ok 19 - test_assert_exclusive_writer_scoped
[  199.534212]     not ok 20 - test_assert_exclusive_access_scoped
[  203.053361]     ok 21 - test_jiffies_noreport
[  206.573803]     ok 22 - test_seqlock_noreport
[  210.093508]     ok 23 - test_atomic_builtins
[  210.094014] not ok 1 - kcsan

clang 14.0.0 @ 657bb7262d4a53e903e702d46fdcab57b7085128:

[   10.341427]     not ok 1 - test_basic
[   13.848960]     not ok 2 - test_concurrent_races
[   17.359671]     ok 3 - test_novalue_change
[   20.869202]     not ok 4 - test_novalue_change_exception
[   24.379067]     not ok 5 - test_unknown_origin
[   27.889492]     ok 6 - test_write_write_assume_atomic
[   31.399572]     not ok 7 - test_write_write_struct
[   34.910833]     not ok 8 - test_write_write_struct_part
[   38.419473]     ok 9 - test_read_atomic_write_atomic
[   41.929642]     not ok 10 - test_read_plain_atomic_write
[   45.439644]     not ok 11 - test_read_plain_atomic_rmw
[   48.950048]     not ok 12 - test_zero_size_access
[   52.459026]     ok 13 - test_data_race
[   55.969806]     not ok 14 - test_assert_exclusive_writer
[   59.480436]     not ok 15 - test_assert_exclusive_access
[   62.990164]     not ok 16 - test_assert_exclusive_access_writer
[   66.499199]     not ok 17 - test_assert_exclusive_bits_change
[   70.009481]     ok 18 - test_assert_exclusive_bits_nochange
[   73.522184]     not ok 19 - test_assert_exclusive_writer_scoped
[   78.030448]     not ok 20 - test_assert_exclusive_access_scoped
[   81.539059]     ok 21 - test_jiffies_noreport
[   85.051769]     ok 22 - test_seqlock_noreport
[   88.572048]     ok 23 - test_atomic_builtins
[   88.572279] not ok 1 - kcsan

[1]: https://github.com/ClangBuiltLinux/continuous-integration2

Cheers,
Nathan
