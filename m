From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Avoiding information leaks between users and between processes by
 default? [Was: : [PATCH 1/5] prctl: add PR_ISOLATE_BP process control]
Date: Wed, 24 Jan 2018 09:37:05 +0100
Message-ID: <20180124083705.GA14868@light.dominikbrodowski.net>
References: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
 <1516712825-2917-2-git-send-email-schwidefsky@de.ibm.com>
 <20180123170719.GA4154@isilmar-4.linta.de>
 <20180124072953.50851fec@mschwideX1>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180124072953.50851fec@mschwideX1>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>, w@1wt.eu, keescook@chromium.org, thomas.lendacky@amd.com, dwmw@amazon.co.uk, ak@linux.intel.com, pavel@ucw.cz
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 24, 2018 at 07:29:53AM +0100, Martin Schwidefsky wrote:
> On Tue, 23 Jan 2018 18:07:19 +0100
> Dominik Brodowski <linux@dominikbrodowski.net> wrote:
>=20
> > On Tue, Jan 23, 2018 at 02:07:01PM +0100, Martin Schwidefsky wrote:
> > > Add the PR_ISOLATE_BP operation to prctl. The effect of the process
> > > control is to make all branch prediction entries created by the execu=
tion
> > > of the user space code of this task not applicable to kernel code or =
the
> > > code of any other task. =20
> >=20
> > What is the rationale for requiring a per-process *opt-in* for this add=
ed
> > protection?
> >=20
> > For KPTI on x86, the exact opposite approach is being discussed (see, e=
.g.
> > http://lkml.kernel.org/r/1515612500-14505-1-git-send-email-w@1wt.eu ): =
By
> > default, play it safe, with KPTI enabled. But for "trusted" processes, =
one
> > may opt out using prctrl.
>=20
> The rationale is that there are cases where you got code from *somewhere*
> and want to run it in an isolated context. Think: a docker container that
> runs under KVM. But with spectre this is still not really safe. So you
> include a wrapper program in the docker container to use the trap door
> prctl to start the potential malicious program. Now you should be good, n=
o?

Well, partly. It may be that s390 and its use cases are special -- but as I
understand it, this uapi question goes beyond this question:

To my understanding, Linux traditionally tried to aim for the security goal
of avoiding information leaks *between* users[+], probably even between
processes of the same user. It wasn't a guarantee, and there always were
(and will be) information leaks -- and that is where additional safeguards
such as seccomp come into play, which reduce the attack surface against
unknown or unresolved security-related bugs. And everyone knew (or should
have known) that allowing "untrusted" code to be run (be it by an user, be
it JavaScript, etc.) is more risky. But still, avoiding information leaks
between users and between processes was (to my understanding) at least a
goal.[=A7]

In recent days however, the outlook on this issue seems to have shifted:

- Your proposal would mean to trust all userspace code, unless it is
  specifically marked as untrusted. As I understand it, this would mean that
  by default, spectre isn't fully mitigated cross-user and cross-process,
  though the kernel could. And rogue user-run code may make use of that,
  unless it is run with a special wrapper.

- Concerning x86 and IPBP, the current proposal is to limit the protection
  offered by IPBP to non-dumpable processes. As I understand it, this would
  mean that other processes are left hanging out to dry.[~]

- Concerning x86 and STIBP, David mentioned that "[t]here's an argument that
  there are so many other information leaks between HT siblings that we
  might not care"; in the last couple of hours, a proposal emerged to limit
  the protection offered by STIBP to non-dumpable processes as well. To my
  understanding, this would mean that many processes are left hanging out to
  dry again.

I am a bit worried whether this is a sign for a shift in the security goals.
I fully understand that there might be processes (e.g. some[?] kernel
threads) and users (root) which you need to trust anyway, as they can
already access anything. Disabling additional, costly safeguards for
those special cases then seems OK. Opting out of additional protections for
single-user or single-use systems (haproxy?) might make sense as well. But
the kernel[*] not offering full[#] spectre mitigation by default for regular
users and their processes? I'm not so sure.

Thanks,
	Dominik


[+] root is different.

[=A7] Whether such goals and their pursuit may have legal relevance -- e.g.
concerning the criminal law protection against unlawful access to data -- is
a related, fascinating topic.

[~] For example, I doubt that mutt sets the non-dumpable flag. But I
wouldn't want other users to be able to read my mail.

[#] Well, at least the best the kernel can currently and reasonably manage.

[*] Whether CPUs should enable full mitigation (IBRS_ALL) by default in fut=
ure
has been discussed on this list as well.
