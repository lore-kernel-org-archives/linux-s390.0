From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Date: Wed, 27 Jan 2016 16:48:45 -0800
Message-ID: <56A9656D.3080707@imgtec.com>
References: <20160113104516.GE25458@arm.com> <5696CF08.8080700@imgtec.com>
	<20160114121449.GC15828@arm.com> <5697F6D2.60409@imgtec.com>
	<20160114203430.GC3818@linux.vnet.ibm.com>
	<56980C91.1010403@imgtec.com>
	<20160114212913.GF3818@linux.vnet.ibm.com>
	<569814F2.50801@imgtec.com>
	<20160114225510.GJ3818@linux.vnet.ibm.com>
	<56983054.4070807@imgtec.com>
	<20160115004753.GN3818@linux.vnet.ibm.com>
	<56984642.3090106@imgtec.com>
	<alpine.DEB.2.00.1601271116520.5958@tp.orcam.me.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9087233927382373719=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1601271116520.5958@tp.orcam.me.uk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Maciej W. Rozycki" <macro@imgtec.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, paulmck@linux.vnet.ibm.com, linux-xtensa@linux-xtensa.org, james.hogan@imgtec.com, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, ddaney.cavm@gmail.com, Thomas Gleixner <tglx@linutronix.de>, linux-me
List-ID: <linux-s390.vger.kernel.org>

--===============9087233927382373719==
Content-Type: multipart/alternative;
	boundary="------------070307010207020903010305"

--------------070307010207020903010305
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

On 01/27/2016 03:26 AM, Maciej W. Rozycki wrote:
> On Fri, 15 Jan 2016, Leonid Yegoshin wrote:
>
>>> So you need to build a different kernel for some types of MIPS systems?
>>> Or do you do boot-time rewriting, like a number of other arches do?
>> I don't know. I would like to have responses. Ralf asked Maciej about old
>> systems and that came nowhere. Even rewrite - don't know what to do with that:
>> no lightweight SYNC or no SYNC at all - yes, it is still possible that SYNC on
>> some systems can be too heavy or even harmful, nobody tested that.
>   I don't recall being asked;
In http://patchwork.linux-mips.org/patch/10505/ the very last mesg 
exchange is:

Maciej,

do you have an R4000 / R4600 / R5000 / R7000 / SiByte system at hand to
test this?
...
   Ralf

Maciej W. Rozycki 
<http://patchwork.linux-mips.org/project/linux-mips/list/?submitter=79> 
- June 5, 2015, 9:18 p.m.

On Fri, 5 Jun 2015, Ralf Baechle wrote:

> do you have an R4000 / R4600 / R5000 / R7000 / SiByte system at hand to
> test this?

  I should be able to check R4400 (that is virtually the same as R4000)
next week or so.  As to SiByte -- not before next month I'm afraid.  I
don't have access to any of the other processors you named.  You may
want to find a better person if you want to accept this change soon.

   Maciej

... and that stops forever...

- Leonid.

--------------070307010207020903010305
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 01/27/2016 03:26 AM, Maciej W.
      Rozycki wrote:<br>
    </div>
    <blockquote
      cite="mid:alpine.DEB.2.00.1601271116520.5958@tp.orcam.me.uk"
      type="cite">
      <pre wrap="">On Fri, 15 Jan 2016, Leonid Yegoshin wrote:

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="">So you need to build a different kernel for some types of MIPS systems?
Or do you do boot-time rewriting, like a number of other arches do?
</pre>
        </blockquote>
        <pre wrap="">
I don't know. I would like to have responses. Ralf asked Maciej about old
systems and that came nowhere. Even rewrite - don't know what to do with that:
no lightweight SYNC or no SYNC at all - yes, it is still possible that SYNC on
some systems can be too heavy or even harmful, nobody tested that.
</pre>
      </blockquote>
      <pre wrap="">
 I don't recall being asked; 
</pre>
    </blockquote>
    In <a class="moz-txt-link-freetext" href="http://patchwork.linux-mips.org/patch/10505/">http://patchwork.linux-mips.org/patch/10505/</a> the very last mesg
    exchange is:<br>
    <br>
    <pre class="content">Maciej,

do you have an R4000 / R4600 / R5000 / R7000 / SiByte system at hand to
test this?
...
  Ralf
</pre>
    <div class="comment">
      <div class="meta"><a
href="http://patchwork.linux-mips.org/project/linux-mips/list/?submitter=79">Maciej
          W. Rozycki</a> - June 5, 2015, 9:18 p.m.</div>
      <pre class="content">On Fri, 5 Jun 2015, Ralf Baechle wrote:
<span class="quote">
&gt; do you have an R4000 / R4600 / R5000 / R7000 / SiByte system at hand to</span>
<span class="quote">&gt; test this?</span>

 I should be able to check R4400 (that is virtually the same as R4000) 
next week or so.  As to SiByte -- not before next month I'm afraid.  I 
don't have access to any of the other processors you named.  You may 
want to find a better person if you want to accept this change soon.

  Maciej
</pre>
    </div>
    ... and that stops forever...<br>
    <br>
    - Leonid.<br>
  </body>
</html>

--------------070307010207020903010305--

--===============9087233927382373719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9087233927382373719==--
