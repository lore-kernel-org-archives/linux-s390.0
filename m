Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/13] make return of 0 explicit
Date: Mon, 19 May 2014 06:31:02 +0200
Message-Id: <1400473875-22228-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: brcm80211-dev-list@broadcom.com
Cc: kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, coreteam@netfilter.org, netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, devel@driverdev.osuosl.org, linux-raid@vger.kernel.org, oprofile-list@lists.sf.net, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Sometimes a local variable is used as a return value in a case where the
return value is always 0.  The result is more apparent if this variable is
just replaced by 0.  This is done by the following semantic patch, although
some cleanups may be needed. (http://coccinelle.lip6.fr/)

// <smpl>
@r exists@
local idexpression ret;
identifier reti;
expression e;
position p;
@@

ret@reti = 0;
... when != \(ret = e\|ret &= e\|ret |= e\|ret += e\|ret -= e\|ret *= e\|ret ^= e\)
    when != \(++ret\|--ret\|ret++\|ret--\)
    when != &ret
return ret;@p

@bad1 exists@
expression e != 0;
local idexpression r.ret;
position r.p;
@@

 \(ret = e\|ret &= e\|ret |= e\|ret += e\|ret -= e\|ret *= e\|ret ^= e\|++ret\|--ret\|ret++\|ret--\|&ret\)
 ...
 return ret;@p

@bad2 exists@
identifier r.reti;
position r.p;
identifier f;
type T;
@@

f(...,T reti,...) {
 ...
 return reti;@p
}

@change depends on !bad1 && !bad2@
position r.p;
local idexpression r.ret;
identifier f;
@@

f(...) { <+...
return 
-ret
+0
;@p
...+> }

@rewrite@
local idexpression r.ret;
expression e;
position p;
identifier change.f;
@@

f(...) { <+...
 \(ret@p = e\|&ret@p\)
...+> }

@depends on change@
local idexpression r.ret;
position p != rewrite.p;
identifier change.f;
@@

f(...) { <+...
(
break;
|
ret = 0;
... when exists
ret@p
... when any
|
- ret = 0;
)
...+> }

@depends on change@
identifier r.reti;
type T;
constant C;
identifier change.f;
@@

f(...) { ... when any
-T reti = C;
 ... when != reti
     when strict
 }

@depends on change@
identifier r.reti;
type T;
identifier change.f;
@@

f(...) { ... when any
-T reti;
 ... when != reti
     when strict
 }
// </smpl>

The first four rules detect cases where only 0 reaches a return.  The
remaining rules clean up any variable initializations or declarations that
are made unnecessary by this change.
