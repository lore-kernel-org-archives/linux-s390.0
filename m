Return-Path: <netdev-owner@vger.kernel.org>
Subject: Re: s390 EAGAIN on send{msg,to}()/recvmsg() on small MTU and big
 packet size
References: <20190923152558.GA31182@dell5510>
From: Wenjia Zhang <wenjia@linux.ibm.com>
Date: Mon, 16 Dec 2019 10:51:13 +0100
MIME-Version: 1.0
In-Reply-To: <20190923152558.GA31182@dell5510>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Message-Id: <ab8289e5-547c-5375-5d0f-e9a363005db1@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Petr Vorel <pvorel@suse.cz>, linux-s390@vger.kernel.org
Cc: Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Petr,

This is not really a bug on s390 but on general linux. A big IP packet is fragmented into small packets according to the MTU size.  Each small packet consumes an amount of system memory, which are recorded in ‘skb->truesize’. And the sum of the space all of the small packets need is limited by ‘2 * sk->sk_sndbuf’ (which you can find in '__ip_append_data' function in net/ipv4/ip_output.c), that is inherited from the system default set during socket initialization. The problem on s390 is that ‘skb->truesize’ is got by aligning the size of the data buffer to the L1 cache line (using SKB_DATA_ALIGN), which on s390 and only on s390 is 256 bytes, while on other processors less than or equal to 128 bytes. So the sum on s390 is much easier to exceed the limit, that the big packet can not be sent successfully.
Because of the big cache line size on s390, the maximum size of the packet is limited in between 53816 and 64960, if the MTU is set to between 484 and 588.
However, this problem not only occurs on s390, but also on some other processor e.g. x86. If the MTU is set to less than 340, an IP packet with the theoretical maximum size (65507 bytes) likewise can not be sent successfully.

Best,              

Wenjia

On 23/09/2019 17:25, Petr Vorel wrote:
> Hi,
>
> I've found a bug on s390 on small MTU combined with big packet size, using ping
> (of course both within valid ranges, e.g. MTU 552 and packet size 61245).
>
> Below is full reproducer on netns.
>
> I tested it on vanilla: v5.3-rc8 and v4.16.
> I reproduced it on current iputils master which uses sendto()/recvmsg() and on
> older version which uses sendmsg()/recvmsg().
>
> As I'm not aware of any s390 specific socket code in kernel I suspect big endian or something else.
>
> This bug was find with LTP/if-mtu-change.sh.
>
> REPRODUCER:
> LTP_NS="ip netns exec ltp_ns"
> ip net add ltp_ns
> ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
> ip li set dev ltp_ns_veth1 netns ltp_ns
> $LTP_NS ip li set lo up
>
> ip xfrm policy flush
> ip xfrm state flush
> ip link set ltp_ns_veth2 down
> ip route flush dev ltp_ns_veth2
> ip addr flush dev ltp_ns_veth2
> ip link set ltp_ns_veth2 up
> ip addr add 10.0.0.2/24 dev ltp_ns_veth2
>
> $LTP_NS ip xfrm policy flush
> $LTP_NS ip xfrm state flush
> $LTP_NS ip link set ltp_ns_veth1 down
> $LTP_NS ip route flush dev ltp_ns_veth1
> $LTP_NS ip addr flush dev ltp_ns_veth1
> $LTP_NS ip link set ltp_ns_veth1 up
> $LTP_NS ip addr add 10.0.0.1/24 dev ltp_ns_veth1
>
> i=552; ip link set dev ltp_ns_veth2 mtu $i; $LTP_NS ip link set dev ltp_ns_veth1 mtu $i # it's enough to set just one of them
>
> ping -I 10.0.0.2 -c 1 10.0.0.1 -s 61245 # fail
> ping -I 10.0.0.2 -c 1 10.0.0.1 -s 61244 # ok
>
> FAIL (iputils-s20121221 from package, using sendmsg())
> ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
> ioctl(1, TIOCGWINSZ, {ws_row=74, ws_col=273, ws_xpixel=1911, ws_ypixel=1050}) = 0
> sendmsg(3, {msg_name(16)={sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("10.0.0.1")}, msg_iov(1)=[{"\10\0\253_\241\373\0\1\0\0\0\0]wf\330\0\0\0\0\0\6\375\201\20\21\22\23\24\25\26\27"..., 61253}], msg_controllen=0, msg_flags=0}, 0) = 61253
> setitimer(ITIMER_REAL, {it_interval={0, 0}, it_value={10, 0}}, NULL) = 0
> recvmsg(3, 0x3fff887b588, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3fff887b588, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3fff887b588, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3fff887b588, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3fff887b588, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3fff887b588, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3fff887b588, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3fff887b588, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3fff887b588, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3fff887b588, 0)            = -1 EINTR (Interrupted system call)
> --- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
> sigreturn({mask=[]})                    = -1 EINTR (Interrupted system call)
>
> OK (iputils-s20121221 from package, using sendmsg())
> ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
> ioctl(1, TIOCGWINSZ, {ws_row=74, ws_col=273, ws_xpixel=1911, ws_ypixel=1050}) = 0
> sendmsg(3, {msg_name(16)={sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("10.0.0.1")}, msg_iov(1)=[{"\10\0\3u\242\266\0\1\0\0\0\0]wgd\0\0\0\0\0\6\340%\20\21\22\23\24\25\26\27"..., 61252}], msg_controllen=0, msg_flags=0}, 0) = 61252
> setitimer(ITIMER_REAL, {it_interval={0, 0}, it_value={10, 0}}, NULL) = 0
> recvmsg(3, {msg_name(16)={sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("10.0.0.1")}, msg_iov(1)=[{"E\0\357X2\277\0\0@\1D\343\n\0\0\1\n\0\0\2\0\0\vu\242\266\0\1\0\0\0\0"..., 61380}], msg_controllen=32, [{cmsg_len=32, cmsg_level=SOL_SOCKET, cmsg_type=0x1d /*
> SCM_??? */, ...}], msg_flags=0}, 0) = 61272
> write(1, "61252 bytes from 10.0.0.1: icmp_"..., 5961252 bytes from 10.0.0.1: icmp_seq=1 ttl=64 time=0.442 ms
> ) = 59
>
> FAIL (current iputils master, using sendto())
> ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
> ioctl(1, TIOCGWINSZ, {ws_row=74, ws_col=273, ws_xpixel=1911, ws_ypixel=1050}) = 0
> sendto(3, "\10\0\2=\313\315\0\1\0\0\0\0]vH;\0\0\0\0\0\7\233o\20\21\22\23\24\25\26\27"..., 61253, 0, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("10.0.0.1")}, 16) = 61253
> setitimer(ITIMER_REAL, {it_interval={0, 0}, it_value={10, 0}}, NULL) = 0
> recvmsg(3, 0x3ffe7e7b388, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3ffe7e7b388, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3ffe7e7b388, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3ffe7e7b388, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3ffe7e7b388, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3ffe7e7b388, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3ffe7e7b388, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3ffe7e7b388, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3ffe7e7b388, 0)            = -1 EAGAIN (Resource temporarily unavailable)
> recvmsg(3, 0x3ffe7e7b388, 0)            = -1 EINTR (Interrupted system call)
> --- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
> sigreturn({mask=[]})                    = -1 EINTR (Interrupted system call)
>
> OK (current iputils master, using sendto())
> ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
> ioctl(1, TIOCGWINSZ, {ws_row=74, ws_col=273, ws_xpixel=1911, ws_ypixel=1050}) = 0
> sendto(3, "\10\0y\4\313\365\0\1\0\0\0\0]vHw\0\0\0\0\0\4`G\20\21\22\23\24\25\26\27"..., 61252, 0, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("10.0.0.1")}, 16) = 61252
> setitimer(ITIMER_REAL, {it_interval={0, 0}, it_value={10, 0}}, NULL) = 0
> recvmsg(3, {msg_name(16)={sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("10.0.0.1")}, msg_iov(1)=[{"E\0\357Xc$\0\0@\1\24~\n\0\0\1\n\0\0\2\0\0\201\4\313\365\0\1\0\0\0\0"..., 61380}], msg_controllen=32, [{cmsg_len=32, cmsg_level=SOL_SOCKET, cmsg_type=0x1d /*
> SCM_??? */, ...}], msg_flags=0}, 0) = 61272
> write(1, "61252 bytes from 10.0.0.1: icmp_"..., 59) = 59
>
> Kind regards,
> Petr
