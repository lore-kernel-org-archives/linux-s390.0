Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729393AbgFHK2Z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jun 2020 06:28:25 -0400
Date: Mon, 8 Jun 2020 12:28:02 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH RESEND] lib: fix bitmap_parse() on 64-bit big endian archs
Message-ID: <20200608102801.GA22989@oc3871087118.ibm.com>
References: <1589798090-11136-1-git-send-email-agordeev@linux.ibm.com>
 <CAHp75VdM2yrpd2d3pK2RkmbhF3yiM4=fiTXL4i3yu3AxV3wY-A@mail.gmail.com>
 <20200518115059.GA19150@oc3871087118.ibm.com>
 <20200602102430.GA17703@oc3871087118.ibm.com>
 <20200605132558.GM2428291@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605132558.GM2428291@smile.fi.intel.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stable <stable@vger.kernel.org>, Yury Norov <yury.norov@gmail.com>, Amritha Nambiar <amritha.nambiar@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Chris Wilson <chris@chris-wilson.co.uk>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steffen Klassert <steffen.klassert@secunet.com>, "Tobin C . Harding" <tobin@kernel.org>, Vineet Gupta <vineet.gupta1@synopsys.com>, Will Deacon <will.deacon@arm.com>, Willem de Bruijn <willemb@google.com>

On Fri, Jun 05, 2020 at 04:25:58PM +0300, Andy Shevchenko wrote:
> Test case, please.

Hi Andy,

Below is the output of the runtime kernel test "test_bitmap".
I resent the patch with Andrew Morton on CC, but did not include
the excessive test output:

test_bitmap: parse: 4: input is 1, result is 0x100000000, expected 0x1
test_bitmap: parse: 5: input is deadbeef, result is 0xdeadbeef00000000, expected 0xdeadbeef
test_bitmap: parse: 6: input is 1,0, result is 0x1, expected 0x100000000
test_bitmap: parse: 7: input is deadbeef,,0,1, result is 0x1, expected 0xdeadbeef
test_bitmap: parse: 8: input is deadbeef,1,0, result is 0x1, expected 0x100000000
test_bitmap: parse: 9: input is baadf00d,deadbeef,1,0, result is 0x1, expected 0x100000000
test_bitmap: parse: 10: input is badf00d,deadbeef,1,0, errno is -75, expected 0
test_bitmap: parse: 11: input is badf00d,deadbeef,1,0, errno is -75, expected 0
test_bitmap: parse: 12: input is   badf00d,deadbeef,1,0  , errno is -75, expected 0
test_bitmap: parse: 13: input is  , badf00d,deadbeef,1,0 , , errno is -75, expected 0
test_bitmap: parse: 14: input is  , badf00d, ,, ,,deadbeef,1,0 , , errno is -75, expected 0
test_bitmap: parse: 16: input is 3,0, errno is 0, expected -75
test_bitmap: parse_user: 4: input is 1, result is 0x100000000, expected 0x1
test_bitmap: parse_user: 5: input is deadbeef, result is 0xdeadbeef00000000, expected 0xdeadbeef
test_bitmap: parse_user: 6: input is 1,0, result is 0x1, expected 0x100000000
test_bitmap: parse_user: 7: input is deadbeef,,0,1, result is 0x1, expected 0xdeadbeef
test_bitmap: parse_user: 8: input is deadbeef,1,0, result is 0x1, expected 0x100000000
test_bitmap: parse_user: 9: input is baadf00d,deadbeef,1,0, result is 0x1, expected 0x100000000
test_bitmap: parse_user: 10: input is badf00d,deadbeef,1,0, errno is -75, expected 0
test_bitmap: parse_user: 11: input is badf00d,deadbeef,1,0, errno is -75, expected 0
test_bitmap: parse_user: 12: input is   badf00d,deadbeef,1,0  , errno is -75, expected 0
test_bitmap: parse_user: 13: input is  , badf00d,deadbeef,1,0 , , errno is -75, expected 0
test_bitmap: parse_user: 14: input is  , badf00d, ,, ,,deadbeef,1,0 , , errno is -75, expected 0
test_bitmap: parse_user: 16: input is 3,0, errno is 0, expected -75

Thanks!


> Yes, you can simulate BE test case on LE platform and vise versa.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
